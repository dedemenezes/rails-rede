require 'rails_helper'

RSpec.describe 'CRUD Gallery', type: :feature do
  before do
    user = create(:coppola)
    login_as user
  end

  it 'updates successufully' do
    gallery = create(:gallery)
    visit edit_dashboard_gallery_path(gallery)
    expect(page).to have_content('Editar')
    expect(page).to have_content('Cancelar')
    fill_in 'gallery_name', with: 'UPDATED Test Gallery'
    check 'gallery_published'
    click_button 'Atualizar Acervo'
    expect(page).to have_content('UPDATED Test Gallery')
    expect(page).to have_selector('input[type="submit"].btn.btn-rede-secondary')
  end

  it 'destroy successufully from index' do
    gallery = create(:gallery)
    visit dashboard_galleries_path
    click_on "destroy_gallery_#{gallery.id}"
    expect(page).to have_content("1 Acervo")
    expect(Gallery.count).to eq(1)
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
