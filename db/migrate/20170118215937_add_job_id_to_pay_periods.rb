class AddJobIdToPayPeriods < ActiveRecord::Migration[5.0]
  def change
    add_reference(:pay_periods, :jobs, index: true)
  end
end
