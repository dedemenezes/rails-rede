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
      fill_in "project_yt_url", with: "http://www.youtube.com/yt_test_pearede"
      fill_in "project_ig_url", with: "https://www.instagram.com/insta23_test_pearede"
      fill_in "project_fb_url", with: "www.facebook.com/fb-test_pearede"

      click_button "commit"

      assert_current_path dashboard_projects_path
    end

    assert_text "Project Name"
    assert_equal "Project Name", @project.reload.name
    assert_equal "ccuc6dgTec0", @project.reload.video_id
    assert_equal "yt_test_pearede", @project.reload.yt_url
    assert_equal "insta23_test_pearede", @project.reload.ig_url
    assert_equal "fb-test_pearede", @project.reload.fb_url
  end
end
