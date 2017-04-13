require 'rails_helper'

RSpec.describe Timesheet, type: :model do
  describe "#add_to_pay_period" do
    let(:job) { create(:job, :biweekly) }
    let(:timesheet) { create(:timesheet, :just_clock_in) }

    it "should add timesheet to pay_period" do
      timesheet.add_to_pay_period(job.id)
      expect(PayPeriod.first.timesheets.include?(timesheet)).to eq true
    end
  end
end
