require "test_helper"

class OrderNamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_name = order_names(:one)
  end

  test "should get index" do
    get order_names_url
    assert_response :success
  end

  test "should get new" do
    get new_order_name_url
    assert_response :success
  end

  test "should create order_name" do
    assert_difference('OrderName.count') do
      post order_names_url, params: { order_name: { content: @order_name.content, system_name_id: @order_name.system_name_id, user_id: @order_name.user_id } }
    end

    assert_redirected_to order_name_url(OrderName.last)
  end

  test "should show order_name" do
    get order_name_url(@order_name)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_name_url(@order_name)
    assert_response :success
  end

  test "should update order_name" do
    patch order_name_url(@order_name), params: { order_name: { content: @order_name.content, system_name_id: @order_name.system_name_id, user_id: @order_name.user_id } }
    assert_redirected_to order_name_url(@order_name)
  end

  test "should destroy order_name" do
    assert_difference('OrderName.count', -1) do
      delete order_name_url(@order_name)
    end

    assert_redirected_to order_names_url
  end
end
