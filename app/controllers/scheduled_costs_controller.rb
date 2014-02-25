class ScheduledCostsController < ApplicationController

  respond_to :html

  def index
    @scheduled_costs = ScheduledCost.chronological
    respond_with @scheduled_costs
  end

  def new
    @scheduled_cost = ScheduledCost.new(params[:scheduled_cost])
    @currencies = CURRENCIES
    respond_with @scheduled_cost
  end

  def create
    attrs = params.require(:scheduled_cost).permit(:date, :cost, :cost_currency, :city, :description)
    @scheduled_cost = ScheduledCost.new(attrs)
    if @scheduled_cost.save
      redirect_to scheduled_costs_path
    else
      respond_with @scheduled_cost
    end
  end

end
