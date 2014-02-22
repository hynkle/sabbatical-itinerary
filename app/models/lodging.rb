class Lodging < ActiveRecord::Base

  validates :name, presence: true
  validates :city, presence: true

  def self.ordered
    order(:city, :name)
  end

end
