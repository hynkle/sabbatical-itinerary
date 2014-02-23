module ApplicationHelper
  
  def format_currency(amount, currency)
    currency.format.gsub(/%{[^{]*}/) do |match|
      outlet = match[2..-2]
      case outlet
      when 'amount' then number_with_precision(amount, precision: 2, delimiter: ',')
      when 'iso_code' then currency.iso_code
      else raise "unexpected outlet \"#{outlet}\" in #{iso_code}'s format"
      end
    end
  end

end
