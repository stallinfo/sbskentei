require "test_helper"

class AsanasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get asanas_index_url
    assert_response :success
  end
end
