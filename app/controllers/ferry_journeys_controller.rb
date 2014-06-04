class FerryJourneysController < ApplicationController

  respond_to :html

  def index
    @ferry_journeys = FerryJourney.order(:departure)
    respond_with @ferry_journeys
  end

  def new
    @ferry_journey = FerryJourney.new(params[:ferry_journey])
    @ferry_terminals = FerryTerminal.order(:name)
    @currencies = CURRENCIES
    respond_with @ferry_journey
  end

  def create
    attrs = params.require(:ferry_journey).permit(:operator, :booked, :required, :cost, :cost_currency, :from_id, :to_id, :departure, :arrival)
    @ferry_journey = FerryJourney.new(attrs)
    if @ferry_journey.save
      redirect_to ferry_journeys_path
    else
      respond_with @ferry_journey
    end
  end

  def edit
    @ferry_journey = FerryJourney.find(params[:id])
    @ferry_journey.attributes = params[:ferry_journey]
    @ferry_terminals = FerryTerminal.order(:name)
    @currencies = CURRENCIES
    respond_with @ferry_journey
  end

  def update
    @ferry_journey = FerryJourney.find(params[:id])
    attrs = params.require(:ferry_journey).permit(:operator, :booked, :required, :cost, :cost_currency, :from_id, :to_id, :departure, :arrival)
    @ferry_journey.attributes = attrs
    if @ferry_journey.save
      redirect_to ferry_journeys_path
    else
      respond_with @ferry_journey
    end
  end

end
