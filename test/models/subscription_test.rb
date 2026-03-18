require "test_helper"

class SubscriptionTest < ActiveSupport::TestCase

  test "is inactive if price nil or 0, active otherwise" do
    assert_equal "inactive", create(:subscription, price: nil).status
    assert_equal "inactive", create(:subscription, price: 0).status
    assert_equal "inactive", create(:subscription, price: -0.1).status
    assert_equal "active", create(:subscription, price: 0.1).status
  end

  test "companies are inactive if subscription is destroyed" do
    subscription = create(:subscription)

    companies = 3.times.map { create(:company, subscription: subscription ) }
    companies.each { |company| assert_equal "active", company.status }

    subscription.destroy!
    companies.each { |company| assert_equal "inactive", company.reload.status }
  end
end