class CreatePlaneJourneys < ActiveRecord::Migration
  def change
    create_table :plane_journeys do |t|
      t.boolean :booked
      t.boolean :paid
      t.decimal :cost, precision: 7, scale: 2
      t.belongs_to :currency
      
      t.timestamps
    end
  end
end
