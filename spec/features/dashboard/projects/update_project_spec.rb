require 'rails_helper'

RSpec.describe 'Updating an existing project from dashboard', js: true do
  it 'updates the project and redirects back to dashboard project list' do
    create(:project)
    user = create(:coppola)
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    expect(page).to have_content 'Login efetuado com sucesso!'

    visit "dashboard/projects/#{Project.last.id}/edit"
    expect(page).to have_content 'Projeto'
    expect(page).to have_field 'project_name', with: 'Project'
    fill_in 'project_name', with: 'Project Name'
    fill_in 'project_video_id', with: 'https://www.youtube.com/watch?v=ccuc6dgTec0&t=5s'
    fill_in 'project_banner_text', with: 'Project banner_textProject banner_textProject banner_text text'
    click_button 'commit'
    expect(page).to have_content 'Project Name'
    expect(Project.last.name).to eq('Project Name')
    expect(Project.last.video_id).to eq('ccuc6dgTec0')
  end
end
