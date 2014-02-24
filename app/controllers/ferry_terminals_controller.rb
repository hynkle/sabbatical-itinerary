class FerryTerminalsController < ApplicationController

  respond_to :html

  def index
    @ferry_terminals = FerryTerminal.order(:name)
    respond_with @ferry_terminals
  end

  def new
    @ferry_terminal = FerryTerminal.new(params[:ferry_terminal])
    respond_with @ferry_terminal
  end

  def create
    attrs = params.require(:ferry_terminal).permit(:name, :lat, :lon, :time_zone)
    @ferry_terminal = FerryTerminal.new(attrs)
    @ferry_terminal.time_zone ||= TimeZoneDB.timezone_from_coordinates(@ferry_terminal.lat, @ferry_terminal.lon)
    if @ferry_terminal.save
      redirect_to ferry_terminals_path
    else
      respond_with @ferry_terminal
    end
  end

end
