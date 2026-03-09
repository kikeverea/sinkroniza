require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  test "can't add user if subscription max was reached" do
    subscription = create(:subscription, max_users: 1)
    company = create(:company, subscription: subscription)

    assert company.can_add_user?

    user = create(:user, company: company)
    refute company.can_add_user?

    user.update!(status: :deleted)
    assert company.can_add_user?
  end
end
