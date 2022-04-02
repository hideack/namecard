require "application_system_test_case"

class TShirtsTest < ApplicationSystemTestCase
  setup do
    @t_shirt = t_shirts(:one)
  end

  test "visiting the index" do
    visit t_shirts_url
    assert_selector "h1", text: "T Shirts"
  end

  test "creating a T shirt" do
    visit t_shirts_url
    click_on "New T Shirt"

    fill_in "Message", with: @t_shirt.message
    fill_in "Pattern", with: @t_shirt.pattern
    click_on "Create T shirt"

    assert_text "T shirt was successfully created"
    click_on "Back"
  end

  test "updating a T shirt" do
    visit t_shirts_url
    click_on "Edit", match: :first

    fill_in "Message", with: @t_shirt.message
    fill_in "Pattern", with: @t_shirt.pattern
    click_on "Update T shirt"

    assert_text "T shirt was successfully updated"
    click_on "Back"
  end

  test "destroying a T shirt" do
    visit t_shirts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "T shirt was successfully destroyed"
  end
end
