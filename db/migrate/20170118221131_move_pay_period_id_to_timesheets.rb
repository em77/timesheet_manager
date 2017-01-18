class MovePayPeriodIdToTimesheets < ActiveRecord::Migration[5.0]
  def change
    remove_reference(:jobs, :pay_period, index: true)
    add_reference(:timesheets, :pay_period, index: true)
  end
end
