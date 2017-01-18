class MovePayFreqToJobs < ActiveRecord::Migration[5.0]
  def change
    remove_column(:companies, :pay_freq)
    add_column(:jobs, :pay_freq, :integer)
  end
end
