require 'test_helper'

class DeliveryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get delivery_index_url
    assert_response :success
  end

end
