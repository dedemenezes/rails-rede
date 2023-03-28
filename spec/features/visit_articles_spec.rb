require 'rails_helper'

RSpec.describe 'Visiting articles index', js: true do
  describe 'GET /articles' do
    it 'sees content' do
      category = FactoryBot.create(:article)
      visit articles_url
      save_screenshot
      expect(page).to have_content('Notícias')
    end
  end
end
