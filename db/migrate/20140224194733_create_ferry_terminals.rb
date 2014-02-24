class CreateFerryTerminals < ActiveRecord::Migration
  def change
    create_table :ferry_terminals do |t|
      t.string :name
      t.string :time_zone
      t.float :lat
      t.float :lon
      t.timestamps
    end
  end
end
