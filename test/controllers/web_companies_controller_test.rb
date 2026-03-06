require "test_helper"

class WebCompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @web_company = web_companies(:one)
  end

  test "should get index" do
    get web_companies_url
    assert_response :success
  end

  test "should get new" do
    get new_web_company_url
    assert_response :success
  end

  test "should create web_company" do
    assert_difference("WebCompany.count") do
      post web_companies_url, params: { web_company: { logo: @web_company.logo, name: @web_company.name, web_company_type: @web_company.web_company_type } }
    end

    assert_redirected_to web_company_url(WebCompany.last)
  end

  test "should show web_company" do
    get web_company_url(@web_company)
    assert_response :success
  end

  test "should get edit" do
    get edit_web_company_url(@web_company)
    assert_response :success
  end

  test "should update web_company" do
    patch web_company_url(@web_company), params: { web_company: { logo: @web_company.logo, name: @web_company.name, web_company_type: @web_company.web_company_type } }
    assert_redirected_to web_company_url(@web_company)
  end

  test "should destroy web_company" do
    assert_difference("WebCompany.count", -1) do
      delete web_company_url(@web_company)
    end

    assert_redirected_to web_companies_url
  end
end
