class TrainStationsController < ApplicationController

  respond_to :html

  def index
    @train_stations = TrainStation.order(:city, :name)
    respond_with @train_stations
  end

  def new
    @train_station = TrainStation.new(params[:train_station])
    respond_with @train_station
  end

  def create
    attrs = params.require(:train_station).permit(:name, :city, :lat, :lon, :time_zone)
    @train_station = TrainStation.new(attrs)
    @train_station.time_zone = TimeZoneDB.timezone_from_coordinates(@train_station.lat, @train_station.lon) if @train_station.time_zone.blank?
    if @train_station.save
      redirect_to train_stations_path
    else
      respond_with @train_station
    end
  end

end

