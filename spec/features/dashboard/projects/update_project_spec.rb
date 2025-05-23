require 'rails_helper'

RSpec.describe 'Updating an existing project from dashboard', type: :feature do
  it 'updates the project and redirects back to dashboard project list' do
    create(:project)
    user = create(:coppola)
    login_as user

    visit "dashboard/projects/#{Project.last.id}/edit"
    expect(page).to have_content 'Projeto'
    expect(page).to have_field 'project_name', with: 'Project'
    fill_in 'project_name', with: 'Project Name'
    fill_in 'project_video_id', with: 'https://www.youtube.com/watch?v=ccuc6dgTec0&t=5s'
    fill_in 'project_banner_text', with: 'Project banner_textProject banner_textProject banner_text text'
    fill_in 'project_yt_url', with: 'yt_test-pearede'
    fill_in 'project_ig_url', with: 'insta_test_pearede'
    fill_in 'project_fb_url', with: 'fb_test_pearede'

    click_button 'commit'
    expect(page).to have_content 'Project Name'
    expect(Project.last.name).to eq('Project Name')
    expect(Project.last.video_id).to eq('ccuc6dgTec0')
  end
end
