class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :from
      t.datetime :date
      t.string :subject
      t.text :raw
      t.timestamps
    end
  end
end
