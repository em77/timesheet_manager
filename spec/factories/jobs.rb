FactoryGirl.define do
  factory :job do
    trait :biweekly do
      id 1
      company_id 1
      employee_profile_id 1
      pay_freq "biweekly"
      pay_cents 1000
      pay_type "wage"
      title "Salesperson"
    end

    trait :monthly do
      pay_freq "monthly"
      pay_cents 1000
      pay_type "wage"
      title "Salesperson"
    end

    trait :inactive_job do
      id 2
      company_id 1
      employee_profile_id 1
      pay_freq "biweekly"
      pay_cents 1000
      pay_type "wage"
      title "Salesperson"
      active_status :inactive
    end
  end
end
