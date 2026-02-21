require "test_helper"

class ShopControllerTest < ActionDispatch::IntegrationTest
  test "should get content" do
    get shop_content_url
    assert_response :success
  end
end
