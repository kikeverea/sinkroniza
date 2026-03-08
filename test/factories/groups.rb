FactoryBot.define do
  factory :group do
    name { "Test group" }
    company
    owner_id { create(:user).id }
    group_type { Group.group_types.to_a.sample.first }
  end
end