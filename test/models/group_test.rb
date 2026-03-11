require "test_helper"

class GroupTest < ActiveSupport::TestCase

  setup do
    Current.user = create(:user)
  end

  test "sets its creator" do
    group = create(:group)
    assert_equal Current.user.id, group.creator_id
  end

  test "creates an owner user" do
    owner = create(:user)

    group = create(:group, owner_id: owner.id)
    group_owner = group.group_users.find_by(role: :owner)

    refute_nil group_owner
    assert_equal owner.id, group_owner.user_id
  end

  test "updates its owner user" do
    owner = create(:user)
    group = create(:group, owner_id: owner.id)

    group_owner = group.group_users.find_by(role: :owner)

    new_owner = create(:user)
    group.update!(owner_id: new_owner.id)

    new_group_owner = group.group_users.find_by(role: :owner)

    assert_nil GroupUser.find_by(id: group_owner.id)
    assert_equal new_owner.id, new_group_owner.user_id
  end

  test "updates group users group_type" do
    group = create(:group, group_type: :personal)
    user_1 = create(:group_user, group: group)
    user_2 = create(:group_user, group: group)

    assert_equal [user_1.group_type, user_2.group_type].uniq, ["personal"]

    group.update!(group_type: :company)

    assert_equal [user_1.reload.group_type, user_2.reload.group_type].uniq, ["company"]
  end

  test "can't add a user twice" do
    owner = create(:user)
    group = create(:group, owner_id: owner.id)

    group.reload
    invalid = build(:group_user, group: group, user: group.owner)

    refute invalid.valid?
  end
end
