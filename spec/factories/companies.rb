FactoryGirl.define do
  factory :company do
    id 1
    title "Acme Inc."
    admin_profile_id 1

    trait :other_admin do
      title "PB&J Inc."
      admin_profile_id 2
    end

    trait :inactive_company do
      id 2
      title "Inactive Company"
      admin_profile_id 1
      active_status :inactive
    end
  end
end
