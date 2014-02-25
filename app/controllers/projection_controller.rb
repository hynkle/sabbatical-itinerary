class ProjectionController < ApplicationController

  respond_to :html, :json

  def show
    respond_with Projection.new
  end

end
