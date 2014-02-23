class Airport < ActiveRecord::Base

  validates :ident, uniqueness: true

  def self.active
    where scheduled_service: true
  end

end
