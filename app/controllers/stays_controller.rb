class StaysController < ApplicationController

  respond_to :html

  def index
    @stays = Stay.chronological
    respond_with :stays
  end

  def new
    @stay = Stay.new(params[:stay])
    @stay.lodging ||= Lodging.new
    respond_with @stay
  end

  def create
    attrs = params.require(:stay).permit(:checkin, :checkout, :booked, :paid, :cost, :currency, lodging_attributes: [:name, :city])
    @stay = Stay.create(attrs)
    if @stay.persisted?
      redirect_to stays_path
    else
      respond_with @stay
    end
  end

end
