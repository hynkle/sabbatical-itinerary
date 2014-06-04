class StaysController < ApplicationController

  respond_to :html

  def index
    @stays = Stay.chronological.present_and_future
    respond_with :stays
  end

  def new
    @stay = Stay.new(params[:stay])
    @stay.lodging ||= Lodging.new
    @currencies = CURRENCIES
    respond_with @stay
  end

  def create
    attrs = params.require(:stay).permit(:checkin, :checkout, :booked, :paid, :cost, :cost_currency, lodging_attributes: [:name, :city])
    @stay = Stay.new(attrs)
    if @stay.save
      redirect_to stays_path
    else
      respond_with @stay
    end
  end

  def edit
    @stay = Stay.find(params[:id])
    @stay.attributes = params[:stay]
    @currencies = CURRENCIES
    respond_with @stay
  end

  def update
    @stay = Stay.find(params[:id])
    attrs = params.require(:stay).permit(:checkin, :checkout, :booked, :paid, :cost, :cost_currency)
    @stay.attributes = attrs
    if @stay.save
      redirect_to stays_path
    else
      respond_with @stay
    end

  end

end
