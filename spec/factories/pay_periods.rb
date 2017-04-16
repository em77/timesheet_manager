FactoryGirl.define do
  factory :pay_period do
    id 1
    job_id 1
    pay_date Date.new(2017, 4, 14)
    start_date Date.new(2017, 3, 16)
    end_date Date.new(2017, 3, 31)

    trait :another_pay_period do
      id 2
      job_id 1
      pay_date Date.new(2017, 4, 30)
    end
  end
end
