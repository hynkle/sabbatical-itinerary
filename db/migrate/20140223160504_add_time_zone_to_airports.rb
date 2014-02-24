class AddTimeZoneToAirports < ActiveRecord::Migration
  def change
    add_column :airports, :time_zone, :string

    %w(from to).each do |airport_association|
      execute <<-SQL
        CREATE FUNCTION shift_flight_times_on_update_of_#{airport_association}_airport_time_zone() RETURNS trigger AS $$
          BEGIN

            UPDATE flights

            SET departure = (
              departure AT TIME ZONE 'UTC'
              AT TIME ZONE OLD.time_zone
              AT TIME ZONE NEW.time_zone
            ),
            arrival = (
              arrival AT TIME ZONE 'UTC'
              AT TIME ZONE OLD.time_zone
              AT TIME ZONE NEW.time_zone
            )

            WHERE flights.#{airport_association}_id = NEW.id;

            RETURN NEW;
          END
        $$ LANGUAGE plpgsql;

        CREATE TRIGGER shift_flight_times_on_update_of_#{airport_association}_airport_time_zone_trigger
        AFTER UPDATE ON airports
        FOR EACH ROW
        WHEN (OLD.time_zone IS DISTINCT FROM NEW.time_zone)
        EXECUTE PROCEDURE shift_flight_times_on_update_of_#{airport_association}_airport_time_zone();
      SQL
    end
  end
end
