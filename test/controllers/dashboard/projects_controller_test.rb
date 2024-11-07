require "test_helper"

class Dashboard::ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:coppola)
  end

  test 'should create a project' do
    assert_difference('Project.count', 1) do
      post dashboard_projects_path, params: {
          project: {
            name: 'Test Project',
            banner_text: 'Lorem ipsum dolor sit, amet consectetur adipisicing elit'
          }
        }
    end
    assert_response :redirect
    assert_redirected_to dashboard_projects_path
  end
end
