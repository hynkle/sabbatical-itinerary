class CreateTrainJourneys < ActiveRecord::Migration
  def change
    create_table :train_journeys do |t|
      t.datetime :departure
      t.datetime :arrival
      t.integer :from_id
      t.integer :to_id
      t.string :operator
      t.boolean :booked
      t.money :cost

      t.timestamps
    end
  end
end
