raise 'Missing TIMEZONEDB_API_KEY environment variable' unless ENV['TIMEZONEDB_API_KEY']

module TimeZoneDB
  include HTTParty
  base_uri 'api.timezonedb.com'
  default_params key: ENV['TIMEZONEDB_API_KEY'], format: 'json'
  format :json

  def self.timezone_from_coordinates(lat, lon)
    get '/', query: {lat: lat, lng: lon}
    return response['zoneName'] if response.success?
  end
end
