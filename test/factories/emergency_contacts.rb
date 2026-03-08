FactoryBot.define do
  factory :emergency_contact do
    owner_user { nil }
    contact_user { nil }
    company { nil }
    status { "MyString" }
    wait_days { 1 }
    encrypted_payload { "MyText" }
    crypto_version { "MyString" }
  end
end
