require "rails_helper"

RSpec.describe PagesHelper, type: :helper do
  describe "#latest_pay_period" do
    it "should return the latest pay period for given job" do
      job = create(:job, :biweekly)
      create(:pay_period)
      later_pp = create(:pay_period, :another_pay_period)
      expect(helper.latest_pay_period(job)).to eq later_pp
    end
  end
end
