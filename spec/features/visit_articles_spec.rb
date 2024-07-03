require 'rails_helper'

RSpec.describe 'Visiting articles index', type: :feature do
  describe 'GET /articles' do
    it 'sees content' do
      visit articles_url
      # save_screenshot
      expect(page).to have_content('Notícias')
    end
  end
end
