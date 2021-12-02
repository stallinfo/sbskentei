require "test_helper"

class KenteiControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get kentei_index_url
    assert_response :success
  end
end
