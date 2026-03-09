require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  test "manager must be a company admin" do
    valid = build(:company, manager: create(:user, :company_admin))
    invalid_1 = build(:company, manager: create(:user, :super_admin))
    invalid_2 = build(:company, manager: create(:user, :user))

    valid.valid?
    invalid_1.valid?
    invalid_2.valid?

    assert valid.errors[:manager].empty?
    refute invalid_1.errors[:manager].empty?
    refute invalid_2.errors[:manager].empty?
  end

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
