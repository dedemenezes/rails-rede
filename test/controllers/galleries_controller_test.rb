require "test_helper"

class GalleriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gallery = galleries(:one)
  end

  test "show includes OG metadata for public access" do
    get gallery_path(@gallery, t: 'documentos')
    assert_response :success

    assert_select "meta[property='og:title'][content='#{@gallery.name} - Rede Observação']"
  end
end
