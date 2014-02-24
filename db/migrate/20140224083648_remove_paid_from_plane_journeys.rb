class RemovePaidFromPlaneJourneys < ActiveRecord::Migration
  def change
    remove_column :plane_journeys, :paid
  end
end
