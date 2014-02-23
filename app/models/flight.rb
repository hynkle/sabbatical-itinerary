class Flight < ActiveRecord::Base
  belongs_to :plane_journey
  belongs_to :from, class_name: 'Airport'
  belongs_to :to, class_name: 'Airport'

  validates :plane_journey, presence: true
  validates :from, presence: true
  validates :to, presence: true
  validates :departure_local, presence: true
  validates :arrival_local, presence: true
end

