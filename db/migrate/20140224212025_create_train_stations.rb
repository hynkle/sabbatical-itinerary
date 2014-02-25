class CreateTrainStations < ActiveRecord::Migration
  def change
    create_table :train_stations do |t|
      t.string :city
      t.string :name
      t.string :time_zone
      t.float :lat
      t.float :lon
      t.timestamps
    end
  end
end
