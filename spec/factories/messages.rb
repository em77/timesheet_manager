FactoryGirl.define do
  factory :message do
    content "This is a message."
    subject "A new message for you"

    trait :second_message do
      content "Another message."
      subject "Another message for you"
    end
  end
end
