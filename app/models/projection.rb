class Projection

  END_OF_TIME = Date.new(2014, 12, 31)
  DAILY_FOOD_EXPENSES = Money.new(4000, 'USD')  # $40

  def initialize
  end

  # sorted
  def balances
    historical_balances + projected_balances
  end

  def as_json
    balances.map(&:as_json)
  end

  def to_json(*_)
    as_json.to_json
  end


  private

  # sorted
  def historical_balances
    @historical_balances ||= FinancialState.includes(:account_balances).map do |fs|
      DateBalance.new(fs.timestamp, fs.balance)
    end.sort
  end

  # sorted
  def projected_balances
    return @projected_balances if defined? @projected_balances

    @projected_balances = []
    balance = latest_historical_balance.amount
    projection_start_date.upto(projection_end_date) do |date|
      expenses = Money.zero
      costs_scheduled_for(date).each do |cost|
        expenses += cost.amount
      end
      expenses += daily_costs(date)

      balance -= expenses
      @projected_balances << DateBalance.new(date, balance)
    end

    @projected_balances
  end

  def daily_costs(date=nil)
    food_expenses = DAILY_FOOD_EXPENSES

    sundry_expenses = case date
      when Date.new(2014,1,2)..Date.new(2014,10,1) then Money.new(3000, 'USD')
      else Money.zero
    end

    food_expenses + sundry_expenses
  end

  def costs_scheduled_for(date)
    costs_by_date[date] || []
  end

  def costs_by_date
    @costs_by_date ||= date_costs.group_by(&:date)
  end

  def projection_start_date
    latest_historical_balance.date
  end

  def date_costs
    return @date_costs if defined? @date_costs
    time_cost_pairs = []
    time_cost_pairs += Stay.unpaid.map(&:payment_event)
    time_cost_pairs += PlaneJourney.unpaid.includes(flights: :from).map(&:payment_event)
    time_cost_pairs += FerryJourney.unpaid.includes(:from, :to).map(&:payment_event)
    time_cost_pairs += TrainJourney.unpaid.includes(:from, :to).map(&:payment_event)
    time_cost_pairs += BusJourney.unpaid.map(&:payment_event)
    time_cost_pairs += ScheduledCost.all.map(&:payment_event)
    @date_costs = time_cost_pairs.map do |time, cost|
      DateCost.new(time, cost)
    end
  end

  def latest_historical_balance
    historical_balances.last
  end

  # # commented out because this is seemingly not actually needed
  # def earliest_historical_balance
  #   earliest_historical_balance.first
  # end

  # # commented out because this is seemingly not actually needed
  # def start_of_time
  #   @start_of_time ||= [earliest_historical_balance.date, Date.today].min
  # end
  
  def projection_end_date
    @projection_end_date ||= [latest_historical_balance.date, END_OF_TIME].max
  end


  class DateAmount

    attr_reader :amount
    attr_reader :dateish

    def initialize(dateish, amount)
      @dateish = dateish
      @amount = amount
    end

    def date
      @date ||= dateish.to_date
    end

    def as_json
      {
        date: date.strftime('%Y-%m-%d'),
        amount: amount.exchange_to(Money.default_currency).to_f
      }
    end

    def <=>(other)
      dateish <=> other.dateish
    end

  end

  class DateCost < DateAmount

  end

  class DateBalance < DateAmount

  end

end
