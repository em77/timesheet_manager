FactoryGirl.define do
  factory :job do
    trait :biweekly do
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
  end
end
