class ChangeJobsReferenceToJobReferenceOnPayPeriods < ActiveRecord::Migration[5.0]
  def change
    remove_reference(:pay_periods, :jobs, index: true)
    add_reference(:pay_periods, :job, index: true)
  end
end
