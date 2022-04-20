require "application_system_test_case"

class SystemNamesTest < ApplicationSystemTestCase
  setup do
    @system_name = system_names(:one)
  end

  test "visiting the index" do
    visit system_names_url
    assert_selector "h1", text: "System Names"
  end

  test "creating a System name" do
    visit system_names_url
    click_on "New System Name"

    fill_in "Content", with: @system_name.content
    fill_in "User", with: @system_name.user_id
    click_on "Create System name"

    assert_text "System name was successfully created"
    click_on "Back"
  end

  test "updating a System name" do
    visit system_names_url
    click_on "Edit", match: :first

    fill_in "Content", with: @system_name.content
    fill_in "User", with: @system_name.user_id
    click_on "Update System name"

    assert_text "System name was successfully updated"
    click_on "Back"
  end

  test "destroying a System name" do
    visit system_names_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "System name was successfully destroyed"
  end
end
