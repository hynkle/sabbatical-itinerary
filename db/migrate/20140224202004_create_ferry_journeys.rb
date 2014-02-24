class CreateFerryJourneys < ActiveRecord::Migration
  def change
    create_table :ferry_journeys do |t|
      t.datetime :departure
      t.datetime :arrival
      t.integer :from_id
      t.integer :to_id
      t.string :operator
      t.boolean :booked
      t.boolean :paid
      t.money :cost

      t.timestamps
    end
  end
end
