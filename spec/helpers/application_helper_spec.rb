require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#current_user_clocked_in?" do
    before(:each) do
      @user = create(:user, :employee)
      allow(helper).to receive(:current_user).and_return(@user)
      create(:job, :biweekly)
      create(:pay_period)
    end

    context "current_user is currently clocked in" do
      it "should return true" do
        create(:timesheet, :just_clock_in)
        expect(helper.current_user_clocked_in?).to eq true
      end
    end

    context "current_user is not currently clocked in" do
      it "should return true" do
        expect(helper.current_user_clocked_in?).to eq false
      end
    end
  end

  describe "#hours_calc" do
    it "should return time difference in hours" do
      clock_in = Time.new(2017, 4, 15, 19, 38, 45, "-04:00")
      clock_out = Time.new(2017, 4, 15, 22, 48, 41, "-04:00")
      expect(helper.hours_calc(clock_in, clock_out)).to eq 3.17
    end
  end

  describe "#current_user_jobs" do
    context "current_user has an active and inactive job" do
      it "should only contain active job in returned collection" do
        user = create(:user, :employee)
        allow(helper).to receive(:current_user).and_return(user)
        job = create(:job, :biweekly)
        create(:job, :inactive_job)
        expect(helper.current_user_jobs.count).to eq 1
        expect(helper.current_user_jobs).to include(job)
      end
    end
  end

  describe "#current_user_companies" do
    context "current_user has an active and inactive company" do
      it "should only contain active company in returned collection" do
        user = create(:user, :admin)
        allow(helper).to receive(:current_user).and_return(user)
        company = create(:company)
        create(:company, :inactive_company)
        expect(helper.current_user_companies.count).to eq 1
        expect(helper.current_user_companies).to include(company)
      end
    end
  end

  describe "#flash_class" do
    context "flash_type is :notice" do
      it "should return bootstrap info alert class" do
        expect(helper.flash_class(:notice)).to eq "alert alert-info"
      end
    end

    context "flash_type is :success" do
      it "should return bootstrap success alert class" do
        expect(helper.flash_class(:success)).to eq "alert alert-success"
      end
    end

    context "flash_type is :error" do
      it "should return bootstrap danger alert class" do
        expect(helper.flash_class(:error)).to eq "alert alert-danger"
      end
    end

    context "flash_type is :alert" do
      it "should return bootstrap warning alert class" do
        expect(helper.flash_class(:alert)).to eq "alert alert-warning"
      end
    end
  end
end
