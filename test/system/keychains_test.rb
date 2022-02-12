require "application_system_test_case"

class KeychainsTest < ApplicationSystemTestCase
  setup do
    @keychain = keychains(:one)
  end

  test "visiting the index" do
    visit keychains_url
    assert_selector "h1", text: "Keychains"
  end

  test "creating a Keychain" do
    visit keychains_url
    click_on "New Keychain"

    click_on "Create Keychain"

    assert_text "Keychain was successfully created"
    click_on "Back"
  end

  test "updating a Keychain" do
    visit keychains_url
    click_on "Edit", match: :first

    click_on "Update Keychain"

    assert_text "Keychain was successfully updated"
    click_on "Back"
  end

  test "destroying a Keychain" do
    visit keychains_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Keychain was successfully destroyed"
  end
end
