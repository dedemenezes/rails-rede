require 'rails_helper'

RSpec.describe 'Create Gallery', type: :feature do
  before do
    user = create(:coppola)
    login_as user
  end

  it 'creates successufully' do
    visit new_dashboard_gallery_path

    expect(page).to have_content('Nome *')
    expect(Gallery.count).to eq(0)
    fill_in 'gallery_name', with: 'Gallery Name'
    check 'gallery_published'
    click_button 'Criar Acervo'
    expect(Gallery.count).to eq(1)
    expect(page).to have_link("gallery_#{Gallery.last.id}")
    expect(page).to have_link("edit_gallery_#{Gallery.last.id}")
  end
end
