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
    attrs = params.require(:lodging).permit(:name, :city)
    @lodging = Lodging.create(attrs)
    if @lodging.persisted?
      redirect_to lodgings_path
    else
      respond_with @lodging
    end
  end

end
