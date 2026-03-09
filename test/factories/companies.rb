FactoryBot.define do
  factory :company do
    name { "Test company" }
    subscription
    manager { create(:user, :company_admin) }
    creator { create(:user, :super_admin) }
  end
end