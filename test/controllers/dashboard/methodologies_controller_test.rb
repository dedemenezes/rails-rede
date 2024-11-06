require "test_helper"

class Dashboard::MethodologiesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_dashboard_methodology_url
    assert_response :success
  end
end
