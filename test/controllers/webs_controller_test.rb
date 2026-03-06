require "test_helper"

class WebsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @web = webs(:one)
  end

  test "should get index" do
    get webs_url
    assert_response :success
  end

  test "should get new" do
    get new_web_url
    assert_response :success
  end

  test "should create web" do
    assert_difference("Web.count") do
      post webs_url, params: { web: { access_url: @web.access_url, active: @web.active, alias: @web.alias, creator_user_id: @web.creator_user_id, creator_user_name: @web.creator_user_name, logo: @web.logo, name: @web.name, send_button: @web.send_button, status: @web.status, web_company_id: @web.web_company_id, web_company_type: @web.web_company_type } }
    end

    assert_redirected_to web_url(Web.last)
  end

  test "should show web" do
    get web_url(@web)
    assert_response :success
  end

  test "should get edit" do
    get edit_web_url(@web)
    assert_response :success
  end

  test "should update web" do
    patch web_url(@web), params: { web: { access_url: @web.access_url, active: @web.active, alias: @web.alias, creator_user_id: @web.creator_user_id, creator_user_name: @web.creator_user_name, logo: @web.logo, name: @web.name, send_button: @web.send_button, status: @web.status, web_company_id: @web.web_company_id, web_company_type: @web.web_company_type } }
    assert_redirected_to web_url(@web)
  end

  test "should destroy web" do
    assert_difference("Web.count", -1) do
      delete web_url(@web)
    end

    assert_redirected_to webs_url
  end
end
