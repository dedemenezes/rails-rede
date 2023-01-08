require 'rails_helper'

RSpec.describe 'Visiting category show', js: true do
  describe 'GET /categories/:id' do
    context 'when category exist' do
      it 'sees content' do
        category = FactoryBot.create(:category)
        visit "/categories/#{category.id}"
        expect(page).to have_content('Category')
      end
    end
  end
end
