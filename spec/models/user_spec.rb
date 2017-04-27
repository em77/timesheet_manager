require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#is_an_admin?" do
    let(:admin) { create(:user, :admin) }
    let(:employee) { create(:user, :employee) }

    context "when user is an admin" do
      it "should return true" do
        return_value = admin.is_an_admin?
        expect(return_value).to eq true
      end
    end

    context "when user is an employee" do
      it "should return false" do
        return_value = employee.is_an_admin?
        expect(return_value).to eq false
      end
    end
  end

  describe "#active_for_authentication?" do
    let(:employee) { create(:user, :employee) }
    let(:inactive_employee) { create(:user, :inactive_employee) }

    context "when user is inactive" do
      it "should return false" do
        return_value = inactive_employee.active_for_authentication?
        expect(return_value).to eq false
      end
    end

    context "when user is active" do
      it "should return true" do
        return_value = employee.active_for_authentication?
        expect(return_value).to eq true
      end
    end
  end

  describe "#full_name" do
    let(:employee) { create(:user, :employee) }

    context "when first_name and last_name are set" do
      it "should return 'first_name last_name'" do
        return_value = employee.full_name
        expect(return_value).to eq "Joe Employee"
      end
    end
  end

  describe "#unread_message_count" do
    let(:user) { create(:user, :employee) }

    context "current_user has 1 message" do
      it "should return 1" do
        create(:message, :specified_rcpt)
        expect(user.unread_message_count).to eq 1
      end
    end

    context "current_user has no messages" do
      it "should return 0" do
        expect(user.unread_message_count).to eq 0
      end
    end
  end
end
