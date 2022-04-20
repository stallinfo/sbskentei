require "test_helper"

class SystemNamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @system_name = system_names(:one)
  end

  test "should get index" do
    get system_names_url
    assert_response :success
  end

  test "should get new" do
    get new_system_name_url
    assert_response :success
  end

  test "should create system_name" do
    assert_difference('SystemName.count') do
      post system_names_url, params: { system_name: { content: @system_name.content, user_id: @system_name.user_id } }
    end

    assert_redirected_to system_name_url(SystemName.last)
  end

  test "should show system_name" do
    get system_name_url(@system_name)
    assert_response :success
  end

  test "should get edit" do
    get edit_system_name_url(@system_name)
    assert_response :success
  end

  test "should update system_name" do
    patch system_name_url(@system_name), params: { system_name: { content: @system_name.content, user_id: @system_name.user_id } }
    assert_redirected_to system_name_url(@system_name)
  end

  test "should destroy system_name" do
    assert_difference('SystemName.count', -1) do
      delete system_name_url(@system_name)
    end

    assert_redirected_to system_names_url
  end
end
