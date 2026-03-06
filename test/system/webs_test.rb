require "application_system_test_case"

class WebsTest < ApplicationSystemTestCase
  setup do
    @web = webs(:one)
  end

  test "visiting the index" do
    visit webs_url
    assert_selector "h1", text: "Webs"
  end

  test "should create web" do
    visit webs_url
    click_on "New web"

    fill_in "Access url", with: @web.access_url
    check "Active" if @web.active
    fill_in "Alias", with: @web.alias
    fill_in "Creator user", with: @web.creator_user_id
    fill_in "Creator user name", with: @web.creator_user_name
    fill_in "Logo", with: @web.logo
    fill_in "Name", with: @web.name
    fill_in "Send button", with: @web.send_button
    fill_in "Status", with: @web.status
    fill_in "Web company", with: @web.web_company_id
    fill_in "Web company type", with: @web.web_company_type
    click_on "Create Web"

    assert_text "Web was successfully created"
    click_on "Back"
  end

  test "should update Web" do
    visit web_url(@web)
    click_on "Edit this web", match: :first

    fill_in "Access url", with: @web.access_url
    check "Active" if @web.active
    fill_in "Alias", with: @web.alias
    fill_in "Creator user", with: @web.creator_user_id
    fill_in "Creator user name", with: @web.creator_user_name
    fill_in "Logo", with: @web.logo
    fill_in "Name", with: @web.name
    fill_in "Send button", with: @web.send_button
    fill_in "Status", with: @web.status
    fill_in "Web company", with: @web.web_company_id
    fill_in "Web company type", with: @web.web_company_type
    click_on "Update Web"

    assert_text "Web was successfully updated"
    click_on "Back"
  end

  test "should destroy Web" do
    visit web_url(@web)
    click_on "Destroy this web", match: :first

    assert_text "Web was successfully destroyed"
  end
end
