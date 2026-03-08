FactoryBot.define do
  factory :subscription do
    name { "Test subscription" }
    quantity_users { rand(3..8) }
  end
end