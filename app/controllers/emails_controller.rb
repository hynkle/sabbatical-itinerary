class EmailsController < ApplicationController

  respond_to :html

  def index
    @emails = Email.chronological
    respond_with @emails
  end

  def create
    params.require(:eml_files)
    binding.pry
  end

end
