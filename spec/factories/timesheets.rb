FactoryGirl.define do
  factory :timesheet do
    trait :just_clock_in do
      clock_in Time.new(2017, 4, 13, 14, 03, 0, "-04:00")
    end
  end
end
