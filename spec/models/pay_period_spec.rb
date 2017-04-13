require 'rails_helper'

RSpec.describe PayPeriod, type: :model do
  describe ".pay_freq_to_pay_period_factory" do
    let(:biweekly_job) { create(:job, :biweekly) }
    let(:monthly_job) { create(:job, :monthly) }
    let(:clock_in) { Time.new(2017, 4, 13, 14, 03, 0, "-04:00") }

    context "when job pays biweekly" do
      it "should return proper start_date, end_date, and pay_date" do
        pp = PayPeriod.pay_freq_to_pay_period_factory(biweekly_job, clock_in)
        expect(pp.start_date).to eq Date.new(2017, 4, 1)
        expect(pp.end_date).to eq Date.new(2017, 4, 15)
        expect(pp.pay_date).to eq Date.new(2017, 5, 1)
      end
    end

    context "when job pays monthly" do
      it "should return proper start_date, end_date, and pay_date" do
        pp = PayPeriod.pay_freq_to_pay_period_factory(monthly_job, clock_in)
        expect(pp.start_date).to eq Date.new(2017, 4, 1)
        expect(pp.end_date).to eq Date.new(2017, 4, 30)
        expect(pp.pay_date).to eq Date.new(2017, 5, 15)
      end
    end
  end
end
