class RemovePayPeriodReferenceFromTimesheets < ActiveRecord::Migration[5.0]
  def change
    remove_reference(:timesheets, :pay_period, index: true)
  end
end
