require "application_system_test_case"

class Dashboard::ProjectsTest < ApplicationSystemTestCase
  setup do
    @project = projects(:one)
    @user = users(:coppola)
    login_as @user
  end

  test "user updates a project from dashboard" do
    assert_changes -> { @project.reload.name } do
      visit edit_dashboard_project_path(@project)

      assert_field "project_name", with: @project.name

      fill_in "project_name", with: "Project Name"
      fill_in "project_video_id", with: "https://www.youtube.com/watch?v=ccuc6dgTec0&t=5s"
      fill_in "project_banner_text", with: "Project banner_textProject banner_textProject banner_text text"
      fill_in "project_yt_url", with: "yt_test-pearede"
      fill_in "project_ig_url", with: "insta_test_pearede"
      fill_in "project_fb_url", with: "fb_test_pearede"

      click_button "commit"

      assert_current_path dashboard_projects_path
    end

    assert_text "Project Name"
    assert_equal "Project Name", @project.reload.name
    assert_equal "ccuc6dgTec0", @project.reload.video_id
  end
end
