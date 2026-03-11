require "test_helper"

class UserTest < ActiveSupport::TestCase

  setup do
    Current.user = create(:user, :super_admin)
    Current.company = create(:company)
  end

  test "a personal user group is created when a user is created" do
    assert_difference "Group.count", 1 do
        assert_difference "GroupUser.count", 1 do
        user = create(:user, :user)

        assert_equal Group.last.group_type, "personal"
        assert_equal Group.last.users.count, 1
        assert_equal GroupUser.last.user_id, user.id
      end
    end
  end
end
