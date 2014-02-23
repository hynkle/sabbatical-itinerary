class CreateStays < ActiveRecord::Migration
  def change
    create_table :stays do |t|
      t.belongs_to :lodging
      t.date :checkin
      t.date :checkout
      t.boolean :booked
      t.boolean :paid
      t.decimal :cost, precision: 7, scale: 2
      t.string :currency

      t.timestamps
    end
  end
end
