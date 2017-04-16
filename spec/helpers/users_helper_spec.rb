require "rails_helper"

RSpec.describe UsersHelper, type: :helper do
  describe "#profile_view_name" do
    context "admin profileable_type" do
      it "should return 'Administrator'" do
        expect(helper.profile_view_name("AdminProfile")).to eq "Administrator"
      end
    end

    context "employee profileable_type" do
      it "should return 'Employee'" do
        expect(helper.profile_view_name("EmployeeProfile")).to eq "Employee"
      end
    end
  end
end
