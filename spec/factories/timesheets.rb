FactoryGirl.define do
  factory :timesheet do
    trait :just_clock_in do
      pay_period_id 1
      clock_in Time.new(2017, 4, 13, 14, 03, 0, "-04:00")
    end
  end
end
