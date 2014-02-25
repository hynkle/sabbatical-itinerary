class CreateAccountBalances < ActiveRecord::Migration
  def change
    create_table :account_balances do |t|
      t.belongs_to :financial_state
      t.string :name
      t.money :balance
      t.boolean :credit, default: false
      t.timestamps
    end
  end
end
