FactoryBot.define do
  factory :group_user do
    group
    user

    role { GroupUser.roles.to_a.sample.first }

    trait :owner do
      role { :owner }
    end

    trait :shared do
      role { :shared }
    end
  end
end