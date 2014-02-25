require 'set'

class FinancialStatesController < ApplicationController

  respond_to :html

  def index
    @financial_states = FinancialState.reverse_chronological.includes(:account_balances)
    respond_with @financial_states
  end

  def new
    @financial_state = if params[:financial_state]
                         FinancialState.new(params[:financial_state])
                       else
                         FinancialState.skeleton_from(FinancialState.most_recent)
                       end
    @financial_state.account_balances.build if @financial_state.account_balances.empty?
    @currencies = CURRENCIES
    respond_with @financial_state
  end

  def create
    attrs = params.require(:financial_state).permit(:timestamp, account_balances_attributes: [:name, :balance, :balance_currency, :credit])

    # don't allow blank balances, as that turns into "0 USD" instead of nil
    if attrs[:account_balances_attributes]
      attrs[:account_balances_attributes].each do |_, attrs|
        attrs[:balance] = nil if attrs[:balance].blank?
      end
    end

    @financial_state = FinancialState.new(attrs)
    @financial_state.timestamp ||= Time.now

    # fill in blank account balances with balance from previous financial_state, if any
    account_balances_with_blank_amounts = @financial_state.account_balances.select{|ab| ab.balance.nil?}
    unless account_balances_with_blank_amounts.empty?
      previous_financial_state = FinancialState.where('timestamp < ?', @financial_state.timestamp).chronological.last
      balances = previous_financial_state.account_balances.each.with_object({}) do |old_ab, hash|
        hash[ [old_ab.balance_currency, old_ab.name] ] = old_ab.balance
      end

      account_balances_with_blank_amounts.each do |blank_ab|
        old_balance = balances[ [blank_ab.balance_currency, blank_ab.name] ]
        blank_ab.balance = old_balance
      end
    end

    if @financial_state.save
      redirect_to financial_states_path
    else
      respond_with @financial_state
    end
  end

end
