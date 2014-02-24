class FerryTerminal < ActiveRecord::Base
  validate :name, presence: true
  validate :lat, presence: true
  validate :lon, presence: true
  validate :time_zone, presence: true, allow_blank: false
end
