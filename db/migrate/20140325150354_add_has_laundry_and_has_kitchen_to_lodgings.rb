class AddHasLaundryAndHasKitchenToLodgings < ActiveRecord::Migration
  def change
    add_column :lodgings, :has_kitchen, :boolean
    add_column :lodgings, :has_laundry, :boolean
  end
end
