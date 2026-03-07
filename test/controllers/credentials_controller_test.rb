require "test_helper"

class CredentialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @credential = credentials(:one)
  end

  test "should get index" do
    get credentials_url
    assert_response :success
  end

  test "should get new" do
    get new_credential_url
    assert_response :success
  end

  test "should create credential" do
    assert_difference("Credential.count") do
      post credentials_url, params: { credential: { active: @credential.active, admin_description: @credential.admin_description, company_id: @credential.company_id, credential_type: @credential.credential_type, description: @credential.description, encrypted_blob: @credential.encrypted_blob, folder_id: @credential.folder_id, group_id: @credential.group_id, mediator_code: @credential.mediator_code, name: @credential.name, owner: @credential.owner, priority: @credential.priority, visible_extension: @credential.visible_extension, web_company_type: @credential.web_company_type, web_id: @credential.web_id } }
    end

    assert_redirected_to credential_url(Credential.last)
  end

  test "should show credential" do
    get credential_url(@credential)
    assert_response :success
  end

  test "should get edit" do
    get edit_credential_url(@credential)
    assert_response :success
  end

  test "should update credential" do
    patch credential_url(@credential), params: { credential: { active: @credential.active, admin_description: @credential.admin_description, company_id: @credential.company_id, credential_type: @credential.credential_type, description: @credential.description, encrypted_blob: @credential.encrypted_blob, folder_id: @credential.folder_id, group_id: @credential.group_id, mediator_code: @credential.mediator_code, name: @credential.name, owner: @credential.owner, priority: @credential.priority, visible_extension: @credential.visible_extension, web_company_type: @credential.web_company_type, web_id: @credential.web_id } }
    assert_redirected_to credential_url(@credential)
  end

  test "should destroy credential" do
    assert_difference("Credential.count", -1) do
      delete credential_url(@credential)
    end

    assert_redirected_to credentials_url
  end
end
