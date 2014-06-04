class BusJourneysController < ApplicationController

  respond_to :html

  def index
    @bus_journeys = BusJourney.present_and_future.chronological
    respond_with @bus_journeys
  end

  def new
    @bus_journey = BusJourney.new(params[:bus_journey])
    @currencies = CURRENCIES
    respond_with @bus_journey
  end

  def create
    attrs = params.require(:bus_journey).permit(:operator, :booked, :cost, :from, :to, :date, :cost_currency)
    @bus_journey = BusJourney.new(attrs)
    if @bus_journey.save
      redirect_to bus_journeys_path
    else
      respond_with @bus_journey
    end
  end
end
