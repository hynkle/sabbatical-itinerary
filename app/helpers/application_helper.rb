module ApplicationHelper
  SECONDS_PER_MINUTE = 60
  MINUTES_PER_HOUR = 60
  SECONDS_PER_HOUR = SECONDS_PER_MINUTE * MINUTES_PER_HOUR
  
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

  def format_duration(a, b)
    seconds = (a-b).abs
    minutes, seconds = seconds.divmod SECONDS_PER_MINUTE
    hours, minutes = minutes.divmod MINUTES_PER_HOUR
    '%dh%02dm' % [hours, minutes]
  end

  def time_zone_difference(start, finish)
    difference_in_hours = (finish.utc_offset - start.utc_offset) / SECONDS_PER_HOUR
    return nil if difference_in_hours == 0
    '(%+d)' % difference_in_hours
  end

end
