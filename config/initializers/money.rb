MoneyRails.configure do |config|

  # To set the default currency
  #
  # config.default_currency = :usd

  Money.default_bank = Money::Bank::OpenExchangeRatesBank.new.tap do |moe|
    moe.app_id = ENV['OPEN_EXCHANGE_RATES_APP_ID'] || raise('Missing required environment variable OPEN_EXCHANGE_RATES_APP_ID')
    moe.cache = Rails.root.join(*%w(tmp cache open_exchange_rates)).to_s
    moe.update_rates
  end

  config.amount_column = {
    prefix: '',           # column name prefix
    postfix: '_subunits', # column name  postfix
    column_name: nil,     # full column name (overrides prefix, postfix and accessor name)
    type: :integer,       # column type
    present: true,        # column will be created
    null: true,           # other options will be treated as column options
  }

  config.currency_column = {
     prefix: '',
     postfix: '_currency',
     column_name: nil,
     type: :string,
     present: true,
     null: true
   }

  # Register a custom currency
  #
  # Example:
  # config.register_currency = {
  #   :priority            => 1,
  #   :iso_code            => "EU4",
  #   :name                => "Euro with subunit of 4 digits",
  #   :symbol              => "€",
  #   :symbol_first        => true,
  #   :subunit             => "Subcent",
  #   :subunit_to_unit     => 10000,
  #   :thousands_separator => ".",
  #   :decimal_mark        => ","
  # }

  # Set money formatted output globally.
  # Default value is nil meaning "ignore this option".
  # Options are nil, true, false.
  #
  # config.no_cents_if_whole = nil
  # config.symbol = nil



  # set currency priorities

  prioritizations = [
    'USD',
    'EUR',
    %w(TRY HUF CZK GBP BGN HRK ILS CHF)
  ].map do |iso_codes|
    Array.wrap(iso_codes).map{|iso_code| iso_code.downcase.to_sym}
  end
  
  prioritizations.each.with_index do |currency_ids, i|
    currency_ids.each do |currency_id|
      attrs = Money::Currency.table[currency_id]
      attrs[:priority] = i + 1
    end
  end

  prioritized = Set.new(prioritizations.flatten)
  unspecified_priority = prioritizations.size + 1
  Money::Currency.table.each do |currency_id, attrs|
    next if prioritized.include? currency_id
    attrs[:priority] = unspecified_priority
  end
end
