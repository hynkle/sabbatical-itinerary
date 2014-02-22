class LodgingsController < ApplicationController

  respond_to :html

  def index
    @lodgings = Lodging.ordered
    respond_with :lodgings
  end

  def new
    @lodging = Lodging.new(params[:lodging])
    respond_with :lodging

  end

  def create
    params.require(:lodging)
    params[:lodging].permit(:name, :city)
    @lodging = Lodging.create(params[:lodging])
    respond_with @lodging
  end

end
