FactoryBot.define do
  factory :user do
    name { "Test" }
    sequence(:lastname) { |i| "User #{i}" }
    sequence(:email) { |i| "user#{i}@mail.com" }
    password { "12341234" }

    trait :super_admin do
      role { :super_admin }
    end

    trait :company_admin do
      role { :company_admin }
    end

    trait :user do
      role { :user }
    end
  end
end