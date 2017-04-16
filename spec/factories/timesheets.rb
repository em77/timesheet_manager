FactoryGirl.define do
  factory :timesheet do
    trait :regular do
      pay_period_id 1
      clock_in Time.new(2017, 4, 15, 10, 03, 0, "-04:00")
      clock_out Time.new(2017, 4, 15, 18, 03, 0, "-04:00")
    end

    trait :just_clock_in do
      pay_period_id 1
      clock_in Time.new(2017, 4, 13, 14, 03, 0, "-04:00")
    end

    trait :approved do
      id 1
      approved_status :approved
      clock_in Time.new(2017, 4, 13, 14, 03, 0, "-04:00")
      clock_out Time.new(2017, 4, 13, 20, 03, 0, "-04:00")
    end

    trait :unapproved do
      id 2
      approved_status :unapproved
      clock_in Time.new(2017, 4, 15, 10, 03, 0, "-04:00")
      clock_out Time.new(2017, 4, 15, 18, 03, 0, "-04:00")
    end
  end
end
