require "rails_helper"

RSpec.describe TimesheetsHelper, type: :helper do
  describe "#status_id_maker" do
    it "should return proper status string" do
      expect(helper.status_id_maker(5)).to eq "status-5"
    end
  end

  describe "#status_css_maker" do
    context "timesheet is approved" do
      it "should return approved css class" do
        timesheet = create(:timesheet, :approved)
        expect(helper.status_css_maker(timesheet)).to eq "glyphicon" +
          " glyphicon-ok status_approved"
      end
    end

    context "timesheet is unapproved" do
      it "should return unapproved css class" do
        timesheet = create(:timesheet, :unapproved)
        expect(helper.status_css_maker(timesheet)).to eq "status_unapproved"
      end
    end
  end

  describe "#timesheets_total_hours" do
    it "should return total hours of timesheets collection" do
      create(:timesheet, :approved)
      create(:timesheet, :unapproved)
      expect(helper.timesheets_total_hours(Timesheet.all)).to eq 14.0
    end
  end
end
