class CreateScheduledCosts < ActiveRecord::Migration
  def change
    create_table :scheduled_costs do |t|
      t.date :date
      t.money :cost
      t.string :city
      t.string :description
      t.timestamps
    end
  end
end
