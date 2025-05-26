require 'rails_helper'

RSpec.describe 'Visiting articles index', type: :feature do
  describe 'GET /articles' do
    it 'sees content' do
      visit articles_url
      # save_screenshot
      expect(page).to have_content('Notícias')
    end
  end
  describe 'GET #show' do
    it 'sees content' do
      article = create(:article)
      visit article_url(article)
      expect(page).to have_content(article.header)
    end
  end
end
