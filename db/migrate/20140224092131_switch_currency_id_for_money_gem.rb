class SwitchCurrencyIdForMoneyGem < ActiveRecord::Migration
  def change
    %w(plane_journeys stays).each do |table|

      add_money table, :cost

      execute <<-SQL
        UPDATE #{table}
        SET
          cost_subunits = (cost * 100)::integer,
          cost_currency = currencies.iso_code
        FROM currencies
        WHERE currencies.id = #{table}.currency_id
      SQL

      remove_column table, :cost
      remove_column table, :currency_id
    end

    drop_table :currencies
  end
end
