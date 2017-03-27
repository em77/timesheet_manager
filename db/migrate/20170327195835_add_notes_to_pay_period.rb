class AddNotesToPayPeriod < ActiveRecord::Migration[5.0]
  def change
    add_column :pay_periods, :notes, :text
  end
end
