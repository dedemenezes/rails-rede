require "application_system_test_case"

class Dashboard::GalleriesTest < ApplicationSystemTestCase
  setup do
    @user = users(:coppola)
    sign_in @user
  end

  test "updates successfully" do
    gallery = galleries(:one)
    visit edit_dashboard_gallery_path(gallery)

    assert_text "Editar"
    assert_text "CANCELAR"

    fill_in "gallery_name", with: "UPDATED Test Gallery"
    # check "gallery_published"
    find('label[for="gallery_published"]').click
    click_button "Atualizar Acervo"

    assert_text "UPDATED Test Gallery"
    assert_selector "input[type='submit'].btn.btn-rede-secondary"
  end

  test "destroys successfully from index" do
    gallery = galleries(:one)
    assert_difference("Gallery.count", -1) do
      visit dashboard_galleries_path

      accept_confirm do
        click_on "destroy_gallery_#{gallery.id}"
      end
      assert_text "Acervo"
      assert_current_path dashboard_galleries_path
    end
  end

  test "creates successfully" do
    assert_difference("Gallery.count", 1) do
      visit new_dashboard_gallery_path

      fill_in "gallery_name", with: "NEW Gallery Name"
      find('label[for="gallery_published"]').click
      # click_button "Criar Acervo"
      click_button 'commit'

      assert_current_path dashboard_galleries_path
    end
  end
end
