class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.belongs_to :flight
      t.datetime :departure_local
      t.datetime :arrival_local
      t.datetime :departure_utc
      t.datetime :arrival_utc
      t.integer :from_id
      t.integer :to_id

      t.timestamps
    end
  end
end
