class ScheduledCost < ActiveRecord::Base
  monetize :cost_subunits, with_model_currency: :cost_currency, allow_nil: false, numericality: {greater_than_or_equal_to: 0}

  validates :date, presence: true
  validates :city, presence: true
  validates :description, presence: true

  def self.chronological
    order(:date)
  end

  def payment_event
    [date, cost]
  end
end
