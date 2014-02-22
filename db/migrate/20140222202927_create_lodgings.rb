class CreateLodgings < ActiveRecord::Migration
  def change
    create_table :lodgings do |t|
      t.string :name
      t.string :city
      t.timestamps
    end
  end
end
