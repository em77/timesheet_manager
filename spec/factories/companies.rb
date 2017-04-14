FactoryGirl.define do
  factory :company do
    title "Acme Inc."
    admin_profile_id 1

    trait :other_admin do
      title "PB&J Inc."
      admin_profile_id 2
    end
  end
end
