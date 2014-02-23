class CreatePlaneJourneys < ActiveRecord::Migration
  def change
    create_table :plane_journeys do |t|

      t.timestamps
    end
  end
end
