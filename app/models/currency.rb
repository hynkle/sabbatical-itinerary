class Currency < ActiveRecord::Base

  validates :iso_code, presence: true, format: /\A[A-Z]{3}\z/, uniqueness: true
  validates :name, presence: true
  validates :format, presence: true
  validates :decimal_digits, presence: true, length: {minimum: 0}

  def to_s
    iso_code
  end

end
