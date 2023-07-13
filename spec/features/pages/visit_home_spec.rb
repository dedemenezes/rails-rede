require 'rails_helper'

RSpec.describe 'Visiting home page', js: true do
  context 'without articles' do
    it 'sees content' do
      project = create(:project)
      visit root_path
      expect(page).to have_content project.banner_text
    end
  end
end
