require "application_system_test_case"

class WebCompaniesTest < ApplicationSystemTestCase
  setup do
    @web_company = web_companies(:one)
  end

  test "visiting the index" do
    visit web_companies_url
    assert_selector "h1", text: "Web companies"
  end

  test "should create web company" do
    visit web_companies_url
    click_on "New web company"

    fill_in "Logo", with: @web_company.logo
    fill_in "Name", with: @web_company.name
    fill_in "Web company type", with: @web_company.web_company_type
    click_on "Create Web company"

    assert_text "Web company was successfully created"
    click_on "Back"
  end

  test "should update Web company" do
    visit web_company_url(@web_company)
    click_on "Edit this web company", match: :first

    fill_in "Logo", with: @web_company.logo
    fill_in "Name", with: @web_company.name
    fill_in "Web company type", with: @web_company.web_company_type
    click_on "Update Web company"

    assert_text "Web company was successfully updated"
    click_on "Back"
  end

  test "should destroy Web company" do
    visit web_company_url(@web_company)
    click_on "Destroy this web company", match: :first

    assert_text "Web company was successfully destroyed"
  end
end
