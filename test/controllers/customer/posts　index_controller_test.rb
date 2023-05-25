require "test_helper"

class Customer::Posts　indexControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get customer_posts　index_show_url
    assert_response :success
  end
end
