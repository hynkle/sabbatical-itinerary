class ExpenditureEventsController < ApplicationController
  respond_to :json

  def index
    date_cost_pairs = []
    date_cost_pairs += Stay.unpaid.map(&:payment_event)
    date_cost_pairs += PlaneJourney.unpaid.includes(flights: [:departure]).map(&:payment_event)

    date_to_cost = Hash.new do |hash, date|
      raise ArgumentError, "expected Date, got #{Date.class}" unless date.is_a? Date
      hash[date] = Money.new(0)
    end

    date_cost_pairs.each do |date, cost|
      date_to_cost[date] += cost
    end

    start_date, end_date = date_to_cost.keys.minmax
    today = Date.today
    start_date = today unless start_date < today
    end_of_2014 = Date.parse('2014-12-31')
    end_date = end_of_2014 unless end_date > end_of_2014

    data = start_date.upto(end_date).map do |date|
      {
        date: date.strftime('%Y-%m-%d'),
        amount: date_to_cost.key?(date) ? date_to_cost[date].amount.to_f : 0
      }
    end

    respond_with data
  end
end
