require "application_system_test_case"

class KmondaisTest < ApplicationSystemTestCase
  setup do
    @kmondai = kmondais(:one)
  end

  test "visiting the index" do
    visit kmondais_url
    assert_selector "h1", text: "Kmondais"
  end

  test "creating a Kmondai" do
    visit kmondais_url
    click_on "New Kmondai"

    fill_in "Answer", with: @kmondai.answer
    fill_in "Explanation", with: @kmondai.explanation
    fill_in "Level", with: @kmondai.level
    fill_in "Number", with: @kmondai.number
    fill_in "Order", with: @kmondai.order
    fill_in "Question", with: @kmondai.question
    fill_in "Suborder", with: @kmondai.suborder
    fill_in "System", with: @kmondai.system
    click_on "Create Kmondai"

    assert_text "Kmondai was successfully created"
    click_on "Back"
  end

  test "updating a Kmondai" do
    visit kmondais_url
    click_on "Edit", match: :first

    fill_in "Answer", with: @kmondai.answer
    fill_in "Explanation", with: @kmondai.explanation
    fill_in "Level", with: @kmondai.level
    fill_in "Number", with: @kmondai.number
    fill_in "Order", with: @kmondai.order
    fill_in "Question", with: @kmondai.question
    fill_in "Suborder", with: @kmondai.suborder
    fill_in "System", with: @kmondai.system
    click_on "Update Kmondai"

    assert_text "Kmondai was successfully updated"
    click_on "Back"
  end

  test "destroying a Kmondai" do
    visit kmondais_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Kmondai was successfully destroyed"
  end
end
