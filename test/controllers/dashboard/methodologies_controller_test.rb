require "test_helper"

class Dashboard::MethodologiesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    sign_in(users(:coppola))

    get '/dashboard/methodologies'
    assert_response :success
  end
end
