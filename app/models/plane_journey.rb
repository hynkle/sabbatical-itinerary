class PlaneJourney < ActiveRecord::Base
  has_many :flights, ->{order :departure}, dependent: :destroy, inverse_of: :plane_journey

  monetize :cost_subunits, with_model_currency: :cost_currency, allow_nil: true, numericality: {greater_than_or_equal_to: 0}

  accepts_nested_attributes_for :flights, reject_if: :all_blank, allow_destroy: true

  def from_city
    flights.first.from_city
  end

  def to_city
    flights.last.to_city
  end

  def departure
    flights.first.departure
  end

  def arrival
    flights.last.arrival
  end
end
