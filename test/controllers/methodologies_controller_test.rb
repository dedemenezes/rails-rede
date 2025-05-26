require "test_helper"

class MethodologiesControllerTest < ActionDispatch::IntegrationTest
  test "GET #show" do
    methodology = methodologies(:flamenguismo)
    get methodology_path(methodology)

    assert_response :success
    assert_select 'h1', text: 'Metodologia Flamenguismo'
  end
end
