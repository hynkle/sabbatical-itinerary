puts "Loading currencies... "
Currency.where(iso_code: 'USD').first_or_initialize.update!(name: 'US dollars',        format: '$%{amount}', decimal_digits: 2) 
Currency.where(iso_code: 'EUR').first_or_initialize.update!(name: 'euros',             format: '€%{amount}', decimal_digits: 2) 
Currency.where(iso_code: 'TRY').first_or_initialize.update!(name: 'Turkish lira',      format: '₺%{amount}', decimal_digits: 2) 
Currency.where(iso_code: 'HUF').first_or_initialize.update!(name: 'Hungarian forints', format: '%{amount} Ft', decimal_digits: 0) 
Currency.where(iso_code: 'CZK').first_or_initialize.update!(name: 'Czech koruna',      format: '%{amount} Kč', decimal_digits: 2) 
Currency.where(iso_code: 'GBP').first_or_initialize.update!(name: 'British pounds',    format: '£%{amount}', decimal_digits: 2) 
Currency.where(iso_code: 'BGN').first_or_initialize.update!(name: 'Bulgarian lev',     format: '%{amount} лв.', decimal_digits: 2) 
Currency.where(iso_code: 'HRK').first_or_initialize.update!(name: 'Croatian kuna',     format: '%{amount} kn', decimal_digits: 2) 
Currency.where(iso_code: 'ILS').first_or_initialize.update!(name: 'Israeli shekels',   format: '₪ %{amount}', decimal_digits: 2) 
Currency.where(iso_code: 'CHF').first_or_initialize.update!(name: 'Swiss francs',      format: '%{amount} %{iso_code}', decimal_digits: 2) 

puts "Loading airports..."
# data from http://www.ourairports.com/data/
require 'csv'
require 'set'
airport_csv_path = Rails.root.join(*%w(db data airports.csv))
airport_idents = Set.new Airport.pluck(:ident)
CSV.foreach(airport_csv_path, headers: true) do |row|
  next if airport_idents.include?(row['ident']) unless ENV['FORCE_AIRPORT_UPDATE']
  next unless row['type'].match /_airport$/
  airport = Airport.where(ident: row['ident']).first_or_initialize
  airport.name = row['name']
  airport.city = row['city']
  size = case row['type']
         when 'large_airport' then 1
         when 'medium_airport' then 2
         when 'small_airport' then 3
         else raise "unexpected airport type #{row['type'].inspect}"
         end
  keywords = row['keywords']
  scheduled_service = row['scheduled_service'] == 'yes' ? true : false
  airport.lat = row['lat']
  airport.lon = row['lon']
  airport.iata_code = row['iata_code']
  airport.local_code = row['local_code']
  airport.save! if airport.new_record? || airport.changed?
end
