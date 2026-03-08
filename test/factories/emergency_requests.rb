FactoryBot.define do
  factory :emergency_request do
    emergency_contact { nil }
    status { "MyString" }
    manual_ar_at { "2026-03-08 17:36:06" }
    grant_at { "2026-03-08 17:36:06" }
    granted_at { "2026-03-08 17:36:06" }
  end
end
