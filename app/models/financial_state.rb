class FinancialState < ActiveRecord::Base
  has_many :account_balances, dependent: :destroy, inverse_of: :financial_state

  accepts_nested_attributes_for :account_balances, reject_if: :all_blank, allow_destroy: true

  validate :validate_in_past

  def balance
    return Money.new(0) if account_balances.empty?
    account_balances.sum(&:balance).exchange_to(Money.default_currency)
  end

  def self.chronological
    order(:timestamp)
  end

  def self.reverse_chronological
    order('timestamp DESC')
  end

  def self.most_recent
    chronological.includes(:account_balances).last
  end

  def self.skeleton_from(other)
    financial_state = new
    return financial_state unless other
    other.account_balances.each do |account_balance|
      financial_state.account_balances.build(
        name: account_balance.name,
        balance_currency: account_balance.balance_currency,
        credit: account_balance.credit?,
        source_balance: account_balance.balance.amount.to_s
      )
    end
    financial_state
  end

  def validate_in_past
    return unless timestamp
    if timestamp > Time.now
      errors[:timestamp].add "can't be in the future"
    end
  end
end
