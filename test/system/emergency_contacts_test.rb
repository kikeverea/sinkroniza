require "application_system_test_case"

class EmergencyContactsTest < ApplicationSystemTestCase
  setup do
    @emergency_contact = emergency_contacts(:one)
  end

  test "visiting the index" do
    visit emergency_contacts_url
    assert_selector "h1", text: "Emergency contacts"
  end

  test "should create emergency contact" do
    visit emergency_contacts_url
    click_on "New emergency contact"

    fill_in "Company", with: @emergency_contact.company_id
    fill_in "Contact user", with: @emergency_contact.contact_user_id
    fill_in "Crypto version", with: @emergency_contact.crypto_version
    fill_in "Encrypted payload", with: @emergency_contact.encrypted_payload
    fill_in "Owner user", with: @emergency_contact.owner_user_id
    fill_in "Status", with: @emergency_contact.status
    fill_in "Wait days", with: @emergency_contact.wait_days
    click_on "Create Emergency contact"

    assert_text "Emergency contact was successfully created"
    click_on "Back"
  end

  test "should update Emergency contact" do
    visit emergency_contact_url(@emergency_contact)
    click_on "Edit this emergency contact", match: :first

    fill_in "Company", with: @emergency_contact.company_id
    fill_in "Contact user", with: @emergency_contact.contact_user_id
    fill_in "Crypto version", with: @emergency_contact.crypto_version
    fill_in "Encrypted payload", with: @emergency_contact.encrypted_payload
    fill_in "Owner user", with: @emergency_contact.owner_user_id
    fill_in "Status", with: @emergency_contact.status
    fill_in "Wait days", with: @emergency_contact.wait_days
    click_on "Update Emergency contact"

    assert_text "Emergency contact was successfully updated"
    click_on "Back"
  end

  test "should destroy Emergency contact" do
    visit emergency_contact_url(@emergency_contact)
    click_on "Destroy this emergency contact", match: :first

    assert_text "Emergency contact was successfully destroyed"
  end
end
