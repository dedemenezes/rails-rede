require "test_helper"

class Dashboard::MethodologiesControllerTest < ActionDispatch::IntegrationTest
  test "should NOT get new" do
    sign_in users(:coppola)
    get new_dashboard_methodology_path

    assert_response :redirect
    assert_redirected_to root_path
  end

  test 'should NOT create a methodology' do
    sign_in users(:coppola)
    rede = create(:rede)

    assert_no_difference('Methodology.count') do
      post dashboard_methodologies_path, params: {
        methodology: {
          name: 'Test Methodology',
          project_id: rede.id,
          description: 'Test methodology description',
          header_one: 'Header test',
          card_description: 'Here it goes your card descripition'
        }
      }
    end
    assert_response :redirect
    assert_redirected_to root_path # not authorized
  end

  test "should get edit" do
    sign_in users(:coppola)
    methodology = create(:methodology)
    get edit_dashboard_methodology_path(methodology)

    assert_response :success
  end

  test "should update methodology" do
    sign_in users(:coppola)
    methodology = create(:methodology)
    id = methodology.id
    assert_changes -> { Methodology.find(id).values_at(:name,) } do
      patch dashboard_methodology_url(methodology), params: { methodology: { name: 'Hello Rails!' } }
    end
    assert 'Hello Rails!', Methodology.find(id).name

    assert_redirected_to dashboard_methodologies_path
  end

end
