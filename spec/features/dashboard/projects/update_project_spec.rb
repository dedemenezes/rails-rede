require 'rails_helper'

RSpec.describe 'Updating an existing project from dashboard', js: true do
    it 'updates the project and redirects back to dashboard project list' do
      project = create(:project)
      user = create(:coppola)
      visit '/users/sign_in'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      expect(page).to have_content 'Login efetuado com sucesso!'

      visit "dashboard/projects/#{project.id}/edit"
      expect(page).to have_content project.name
    end
end
