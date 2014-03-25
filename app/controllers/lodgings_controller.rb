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
    attrs = params.require(:lodging).permit(:name, :city, :has_laundry, :has_kitchen)
    @lodging = Lodging.new(attrs)
    if @lodging.save
      redirect_to lodgings_path
    else
      respond_with @lodging
    end
  end

  def edit
    @lodging = Lodging.find(params[:id])
    @lodging.attributes = params[:lodging]
    respond_with @lodging
  end

  def update
    @lodging = Lodging.find(params[:id])
    attrs = params.require(:lodging).permit(:name, :city, :has_laundry, :has_kitchen)
    @lodging.attributes = attrs
    if @lodging.save
      redirect_to lodgings_path
    else
      respond_with @lodging
    end
  end

end
