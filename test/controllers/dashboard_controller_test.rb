require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    sign_in(users(:coppola))


    get home_url
    assert_response :success
  end
end
