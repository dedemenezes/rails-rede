require "test_helper"

class Dashboard::MethodologiesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get dashboard_methodologies_new_url
    assert_response :success
  end
end
