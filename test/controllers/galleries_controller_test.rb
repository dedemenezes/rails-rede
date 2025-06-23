require "test_helper"

class GalleriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gallery = galleries(:one)
  end

  test "show includes OG metadata for public access" do
    get gallery_path(@gallery, t: 'imagens')
    assert_response :success

    assert_select "meta[property='og:title'][content='#{@gallery.name} - Rede Observação']"
  end

  test 'should get acervos/imagens' do
    get imagens_galleries_path
    assert_response :success
  end
end
