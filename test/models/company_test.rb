require "test_helper"

class CompanyTest < ActiveSupport::TestCase

  test "invalid if subscription is not present" do
    company = Company.new
    company.valid?

    refute_empty company.errors[:subscription_id]
  end

  test "can remove a subscription" do
    company = create(:company)
    company.update!(subscription: nil)

    assert_nil company.subscription
  end

  test "removing a subscription makes the company inactive" do
    company = create(:company)
    assert_equal "active", company.status

    company.update!(subscription: nil)
    assert_equal "inactive", company.status
  end

  test "can't add user if subscription max was reached" do
    current_user = create(:user, :super_admin)
    Current.user = current_user

    subscription = create(:subscription, max_users: 1)
    company = create(:company, subscription: subscription)
    Current.company = company

    assert company.can_add_user?

    user = create(:user, company: company)
    refute company.can_add_user?

    user.update!(status: :deleted)
    assert company.can_add_user?
  end
end
