require "application_system_test_case"

class ClassificationNamesTest < ApplicationSystemTestCase
  setup do
    @classification_name = classification_names(:one)
  end

  test "visiting the index" do
    visit classification_names_url
    assert_selector "h1", text: "Classification Names"
  end

  test "creating a Classification name" do
    visit classification_names_url
    click_on "New Classification Name"

    fill_in "Content", with: @classification_name.content
    fill_in "Order name", with: @classification_name.order_name_id
    fill_in "User", with: @classification_name.user_id
    click_on "Create Classification name"

    assert_text "Classification name was successfully created"
    click_on "Back"
  end

  test "updating a Classification name" do
    visit classification_names_url
    click_on "Edit", match: :first

    fill_in "Content", with: @classification_name.content
    fill_in "Order name", with: @classification_name.order_name_id
    fill_in "User", with: @classification_name.user_id
    click_on "Update Classification name"

    assert_text "Classification name was successfully updated"
    click_on "Back"
  end

  test "destroying a Classification name" do
    visit classification_names_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Classification name was successfully destroyed"
  end
end
