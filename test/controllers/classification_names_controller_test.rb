require "test_helper"

class ClassificationNamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @classification_name = classification_names(:one)
  end

  test "should get index" do
    get classification_names_url
    assert_response :success
  end

  test "should get new" do
    get new_classification_name_url
    assert_response :success
  end

  test "should create classification_name" do
    assert_difference('ClassificationName.count') do
      post classification_names_url, params: { classification_name: { content: @classification_name.content, order_name_id: @classification_name.order_name_id, user_id: @classification_name.user_id } }
    end

    assert_redirected_to classification_name_url(ClassificationName.last)
  end

  test "should show classification_name" do
    get classification_name_url(@classification_name)
    assert_response :success
  end

  test "should get edit" do
    get edit_classification_name_url(@classification_name)
    assert_response :success
  end

  test "should update classification_name" do
    patch classification_name_url(@classification_name), params: { classification_name: { content: @classification_name.content, order_name_id: @classification_name.order_name_id, user_id: @classification_name.user_id } }
    assert_redirected_to classification_name_url(@classification_name)
  end

  test "should destroy classification_name" do
    assert_difference('ClassificationName.count', -1) do
      delete classification_name_url(@classification_name)
    end

    assert_redirected_to classification_names_url
  end
end
