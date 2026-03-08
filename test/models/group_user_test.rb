require "test_helper"

class GroupUserTest < ActiveSupport::TestCase

  setup do
    Current.user = create(:user)
  end

  test "sets its own group type" do
    group = create(:group)
    group_user = create(:group_user, group: group)

    assert_equal group.group_type, group_user.group_type
  end

  test "aborts destroy if it's owner" do
    group_user = create(:group_user, :owner)

    assert_no_difference("GroupUser.count") do
      was_destroyed = group_user.destroy
      refute was_destroyed
    end
  end

  test "destroys it's owner, if its group allows it" do
    group_user = create(:group_user, :owner)
    group_user.group.allows_owner_destroy = true

    assert_difference("GroupUser.count", -1) do
      was_destroyed = group_user.destroy
      assert was_destroyed
    end
  end
end
