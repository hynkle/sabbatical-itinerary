class TrainStation < ActiveRecord::Base
  validate :name, presence: true
  validate :city, presence: true
  validate :lat, presence: true
  validate :lon, presence: true
  validate :time_zone, presence: true, allow_blank: false

  def to_s
    if I18n.transliterate(name)[I18n.transliterate(city)]
      name
    else
      "(#{city}) #{name}"
    end
  end
end
