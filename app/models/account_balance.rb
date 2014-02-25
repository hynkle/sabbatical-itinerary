class AccountBalance < ActiveRecord::Base
  belongs_to :financial_state, inverse_of: :account_balances

  monetize :balance_subunits, with_model_currency: :balance_currency, allow_nil: false

  validates :balance, presence: true
  validates :financial_state, presence: true
  validates :name, presence: true, uniqueness: {scope: [:financial_state, :balance_currency]}
  validate :validates_sign

  attr_accessor :source_balance

  def validates_sign
    return unless balance
    if credit? && balance.positive?
      errors.add(:balance, 'must be negative for a credit account')
    elsif !credit && balance.negative?
      errors.add(:balance, 'must be positive')
    end
  end
end
