class PlaneJourneysController < ApplicationController

  respond_to :html

  def index
    @plane_journeys = PlaneJourney.includes(flights: [:from, :to]).sort_by(&:departure)
    respond_with @plane_journeys
  end

  def new
    @plane_journey = PlaneJourney.new(params[:plane_journey])
    @plane_journey.flights.build
    @airports = Airport.active.with_time_zone.order(:city)
    @currencies = CURRENCIES
    respond_with @plane_journey
  end

  def create
    attrs = params.require(:plane_journey).permit(:airline, :booked, :required, :cost, :cost_currency, flights_attributes: [:from_id, :to_id, :departure, :arrival])
    @plane_journey = PlaneJourney.new(attrs)
    if @plane_journey.save
      redirect_to plane_journeys_path
    else
      respond_with @plane_journey
    end
  end

end
