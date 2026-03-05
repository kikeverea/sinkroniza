require "application_system_test_case"

class CompaniesTest < ApplicationSystemTestCase
  setup do
    @company = companies(:one)
  end

  test "visiting the index" do
    visit companies_url
    assert_selector "h1", text: "Companies"
  end

  test "should create company" do
    visit companies_url
    click_on "New company"

    check "Active" if @company.active
    fill_in "Address", with: @company.address
    fill_in "Cp", with: @company.cp
    fill_in "Creator user", with: @company.creator_user_id
    fill_in "Creator user name", with: @company.creator_user_name
    fill_in "Legal name", with: @company.legal_name
    fill_in "Logo", with: @company.logo
    fill_in "Manager email", with: @company.manager_email
    fill_in "Manager lastname", with: @company.manager_lastname
    fill_in "Manager name", with: @company.manager_name
    fill_in "Manager nif", with: @company.manager_nif
    fill_in "Manager phone", with: @company.manager_phone
    fill_in "Name", with: @company.name
    fill_in "Status", with: @company.status
    fill_in "Subscription", with: @company.subscription_id
    fill_in "Tax", with: @company.tax_id
    click_on "Create Company"

    assert_text "Company was successfully created"
    click_on "Back"
  end

  test "should update Company" do
    visit company_url(@company)
    click_on "Edit this company", match: :first

    check "Active" if @company.active
    fill_in "Address", with: @company.address
    fill_in "Cp", with: @company.cp
    fill_in "Creator user", with: @company.creator_user_id
    fill_in "Creator user name", with: @company.creator_user_name
    fill_in "Legal name", with: @company.legal_name
    fill_in "Logo", with: @company.logo
    fill_in "Manager email", with: @company.manager_email
    fill_in "Manager lastname", with: @company.manager_lastname
    fill_in "Manager name", with: @company.manager_name
    fill_in "Manager nif", with: @company.manager_nif
    fill_in "Manager phone", with: @company.manager_phone
    fill_in "Name", with: @company.name
    fill_in "Status", with: @company.status
    fill_in "Subscription", with: @company.subscription_id
    fill_in "Tax", with: @company.tax_id
    click_on "Update Company"

    assert_text "Company was successfully updated"
    click_on "Back"
  end

  test "should destroy Company" do
    visit company_url(@company)
    click_on "Destroy this company", match: :first

    assert_text "Company was successfully destroyed"
  end
end
