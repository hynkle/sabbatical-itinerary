class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.belongs_to :plane_journey
      t.datetime :departure
      t.datetime :arrival
      t.integer :from_id
      t.integer :to_id

      t.timestamps
    end
  end
end
