require "application_system_test_case"

class OrderNamesTest < ApplicationSystemTestCase
  setup do
    @order_name = order_names(:one)
  end

  test "visiting the index" do
    visit order_names_url
    assert_selector "h1", text: "Order Names"
  end

  test "creating a Order name" do
    visit order_names_url
    click_on "New Order Name"

    fill_in "Content", with: @order_name.content
    fill_in "System name", with: @order_name.system_name_id
    fill_in "User", with: @order_name.user_id
    click_on "Create Order name"

    assert_text "Order name was successfully created"
    click_on "Back"
  end

  test "updating a Order name" do
    visit order_names_url
    click_on "Edit", match: :first

    fill_in "Content", with: @order_name.content
    fill_in "System name", with: @order_name.system_name_id
    fill_in "User", with: @order_name.user_id
    click_on "Update Order name"

    assert_text "Order name was successfully updated"
    click_on "Back"
  end

  test "destroying a Order name" do
    visit order_names_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order name was successfully destroyed"
  end
end
