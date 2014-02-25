class CreateFinancialStates < ActiveRecord::Migration
  def change
    create_table :financial_states do |t|
      t.datetime :timestamp
      t.timestamps
    end
  end
end
