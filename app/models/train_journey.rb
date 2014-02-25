class TrainJourney < ActiveRecord::Base
  belongs_to :from, class_name: 'TrainStation'
  belongs_to :to, class_name: 'TrainStation'

  validates :from, presence: true
  validates :to, presence: true
  validates :departure, presence: true
  validates :arrival, presence: true

  monetize :cost_subunits, with_model_currency: :cost_currency, allow_nil: true, numericality: {greater_than_or_equal_to: 0}

  def self.unpaid
    unbooked
  end

  def self.unbooked
    where booked: false
  end

  def departure_time_zone
    from.time_zone
  end

  def arrival_time_zone
    to.time_zone
  end

  def departure=(time)
    write_attribute :departure, ActiveSupport::TimeZone[departure_time_zone].parse(time)
  end

  def arrival=(time)
    write_attribute :arrival, ActiveSupport::TimeZone[arrival_time_zone].parse(time)
  end

  def departure
    read_attribute(:departure).in_time_zone(departure_time_zone)
  end

  def arrival
    read_attribute(:arrival).in_time_zone(arrival_time_zone)
  end

  def from_name
    from.name
  end

  def to_name
    to.name
  end

  def from_city
    from.city
  end

  def to_city
    to.city
  end

  def payment_event
    [departure.to_date, cost]
  end

  def paid?
    booked?
  end
end
