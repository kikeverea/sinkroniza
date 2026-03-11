FactoryBot.define do
  factory :company do
    sequence(:name) { |i| "Test company #{i}" }
    subscription
    creator { Current.user || create(:user, :super_admin) }
  end
end