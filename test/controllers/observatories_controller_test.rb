require "test_helper"

class ObservatoriesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'index lists published observatories' do
    create(:observatory)
    create(:ninho_do_urubu)

    get observatories_url

    assert_response :success
    assert_select 'h1', text: "Observatórios"
    assert_select '.observatory__card', count: 1
  end
end
