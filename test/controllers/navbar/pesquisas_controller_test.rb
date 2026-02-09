require "test_helper"

class Navbar::PesquisasControllerTest < ActionDispatch::IntegrationTest
  test "GET index" do
    get navbar_pesquisas_url
    assert_response :success
  end
end
