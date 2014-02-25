class TrainJourneysController < ApplicationController

  respond_to :html

  def index
    @train_journeys = TrainJourney.order(:departure)
    respond_with @train_journeys
  end

  def new
    @train_journey = TrainJourney.new(params[:train_journey])
    @train_stations = TrainStation.order(:city, :name)
    @currencies = CURRENCIES
    respond_with @train_journey
  end

  def create
    attrs = params.require(:train_journey).permit(:operator, :booked, :required, :cost, :cost_currency, :from_id, :to_id, :departure, :arrival)
    @train_journey = TrainJourney.new(attrs)
    if @train_journey.save
      redirect_to train_journeys_path
    else
      respond_with @train_journey
    end
  end

end
