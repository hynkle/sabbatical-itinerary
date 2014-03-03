class CreateBusJourneys < ActiveRecord::Migration
  def change
    create_table :bus_journeys do |t|
      t.string :from
      t.string :to
      t.date :date
      t.string :operator
      t.boolean :booked
      t.money :cost

      t.timestamps
    end
  end
end
