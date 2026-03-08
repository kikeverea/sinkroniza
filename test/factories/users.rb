FactoryBot.define do
  factory :user do
    name { "Test" }
    sequence(:lastname) { |i| "User #{i}" }
    sequence(:email) { |i| "user#{i}@mail.com" }
    password { "12341234" }
  end
end