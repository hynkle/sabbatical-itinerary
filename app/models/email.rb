require 'mail'

class Email < ActiveRecord::Base

  def self.chronological
    order :date
  end

  def self.from_eml(eml)
    message = Mail.read_from_string(eml)
    binding.pry
  end

end
