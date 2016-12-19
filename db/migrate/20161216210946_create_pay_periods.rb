class CreatePayPeriods < ActiveRecord::Migration[5.0]
  def change
    create_table :pay_periods do |t|
      t.date :start_date
      t.date :end_date
      t.date :pay_date

      t.timestamps
    end
  end
end
