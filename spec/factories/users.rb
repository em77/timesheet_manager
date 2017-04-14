FactoryGirl.define do
  factory :user do
    trait :admin do
      email "admin@test.com"
      first_name "John"
      last_name "Admin"
      username "admin"
      profileable_type "AdminProfile"
      password "password"
    end

    trait :other_admin do
      email "admin2@test.com"
      first_name "David"
      last_name "Admin"
      username "admin2"
      profileable_type "AdminProfile"
      password "password"
    end

    trait :employee do
      email "employee@test.com"
      first_name "Joe"
      last_name "Employee"
      username "employee"
      profileable_type "EmployeeProfile"
      password "password"
    end

    trait :inactive_employee do
      email "employee@test.com"
      first_name "Joe"
      last_name "Inactive Employee"
      username "employee"
      profileable_type "EmployeeProfile"
      password "password"
      active_status :inactive
    end
  end
end
