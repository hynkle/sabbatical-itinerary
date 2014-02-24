class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  CURRENCIES = Money::Currency.all.sort_by{|c| [c.priority, c.iso_code, c.name]}.freeze
end
