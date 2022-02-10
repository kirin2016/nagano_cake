require 'test_helper'

class AdminHomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get admin_homes_top_url
    assert_response :success
  end

end
