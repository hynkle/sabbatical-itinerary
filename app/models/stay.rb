class Stay < ActiveRecord::Base
  belongs_to :lodging
  belongs_to :currency
  validates :lodging, presence: true
  validates :checkin, presence: true
  validates :checkout, presence: true
  validate :validate_nonoverlapping

  accepts_nested_attributes_for :lodging

  def self.chronological
    order(:checkin)
  end

  def nights
    (checkout - checkin).to_i
  end

  def overlapping_stays
    # This method obviously doesn't work right if checkin or checkout is missing.
    # It also doesn't work if the caller is persisted.
    Stay.where('? > checkin and checkout > ?', checkin, checkout)
  end

  def validate_nonoverlapping
    return unless checkin && checkout
    if overlapping_stays.exists?
      errors.add(:checkin, 'cannot overlap another stay')
      errors.add(:checkout, '')
    end
  end
end
