class AddAirlineToPlaneJourneys < ActiveRecord::Migration
  def change
    add_column :plane_journeys, :airline, :string
  end
end
