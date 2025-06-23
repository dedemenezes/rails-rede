require "test_helper"

class Dashboard::ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:coppola)
  end

  test 'should get index' do
    get dashboard_projects_url
    assert_response :success
  end

  test 'should get new' do
    get new_dashboard_project_url
    assert_response :success
  end

  test 'should create a project with valid attributes' do
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

  test 'should NOT create a project with invalid attributes' do
    assert_no_difference -> { Project.count } do
      post dashboard_projects_path, params: {
          project: {
            name: 'Test Project',
          }
        }
    end
    assert_response :unprocessable_entity
    # assert_redirected_to dashboard_projects_path
  end

  test 'should get edit' do
    project = projects(:one)

    get edit_dashboard_project_url(project)
    assert_response :success
  end

  test "should update project with valid attributes" do
    project = projects(:one)
    id = project.id
    assert 'Rede Observacao', project.name
    assert "Rede ObservacaoRede ObservacaoRede ObservacaoRede Observacao", project.banner_text
    assert_changes -> { Project.find(id).values_at(:name, :banner_text) } do
      patch dashboard_project_url(project), params: { project: { name: 'UPDATED Rede', banner_text: 'Hello Rails!Hello Rails!Hello Rails!Hello Rails!Hello Rails!Hello Rails!Hello Rails!Hello Rails!' } }
    end
    assert 'Hello Rails!Hello Rails!Hello Rails!Hello Rails!Hello Rails!Hello Rails!Hello Rails!Hello Rails!', Project.find(id).name


    assert_redirected_to dashboard_projects_path
  end

  test "should NOT update project with invalid attributes" do
    project = projects(:one)
    id = project.id
    assert 'Rede Observacao', project.name
    assert "Rede ObservacaoRede ObservacaoRede ObservacaoRede Observacao", project.banner_text
    assert_no_changes -> { Project.find(id).values_at(:banner_text) } do
      patch dashboard_project_url(project), params: { project: { banner_text: 'Hello Rails!' } }
    end
    assert_response :unprocessable_entity
  end
end
