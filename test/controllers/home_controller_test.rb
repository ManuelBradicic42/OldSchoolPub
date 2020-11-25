require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    puts root_url
    assert_response :success
  end

  test "The title should be" do
    get root_url
    assert_select 'title', 'OldSchoolPub'
    assert_response :success
  end
end
