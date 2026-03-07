require "application_system_test_case"

class CredentialsTest < ApplicationSystemTestCase
  setup do
    @credential = credentials(:one)
  end

  test "visiting the index" do
    visit credentials_url
    assert_selector "h1", text: "Credentials"
  end

  test "should create credential" do
    visit credentials_url
    click_on "New credential"

    check "Active" if @credential.active
    fill_in "Admin description", with: @credential.admin_description
    fill_in "Company", with: @credential.company_id
    fill_in "Credential type", with: @credential.credential_type
    fill_in "description", with: @credential.description
    fill_in "Encrypted blob", with: @credential.encrypted_blob
    fill_in "Folder", with: @credential.folder_id
    fill_in "Group", with: @credential.group_id
    fill_in "Mediator code", with: @credential.mediator_code
    fill_in "Name", with: @credential.name
    fill_in "Owner", with: @credential.owner
    fill_in "Priority", with: @credential.priority
    check "Visible extension" if @credential.visible_extension
    fill_in "Web company type", with: @credential.web_company_type
    fill_in "Web", with: @credential.web_id
    click_on "Create Credential"

    assert_text "Credential was successfully created"
    click_on "Back"
  end

  test "should update Credential" do
    visit credential_url(@credential)
    click_on "Edit this credential", match: :first

    check "Active" if @credential.active
    fill_in "Admin description", with: @credential.admin_description
    fill_in "Company", with: @credential.company_id
    fill_in "Credential type", with: @credential.credential_type
    fill_in "description", with: @credential.description
    fill_in "Encrypted blob", with: @credential.encrypted_blob
    fill_in "Folder", with: @credential.folder_id
    fill_in "Group", with: @credential.group_id
    fill_in "Mediator code", with: @credential.mediator_code
    fill_in "Name", with: @credential.name
    fill_in "Owner", with: @credential.owner
    fill_in "Priority", with: @credential.priority
    check "Visible extension" if @credential.visible_extension
    fill_in "Web company type", with: @credential.web_company_type
    fill_in "Web", with: @credential.web_id
    click_on "Update Credential"

    assert_text "Credential was successfully updated"
    click_on "Back"
  end

  test "should destroy Credential" do
    visit credential_url(@credential)
    click_on "Destroy this credential", match: :first

    assert_text "Credential was successfully destroyed"
  end
end
