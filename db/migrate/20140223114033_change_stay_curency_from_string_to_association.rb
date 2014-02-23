class ChangeStayCurencyFromStringToAssociation < ActiveRecord::Migration
  def change
    add_column :stays, :currency_id, :integer
    execute <<-SQL
      UPDATE stays SET currency_id = (
        SELECT id FROM currencies
        WHERE iso_code = stays.currency
        LIMIT 1
      )
    SQL
    remove_column :stays, :currency
  end
end
