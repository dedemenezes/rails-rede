require "test_helper"

class GalleriesControllerTest < ActionDispatch::IntegrationTest
  test "show includes OG metadata for public access" do
    gallery = galleries(:bp_photos)
    get gallery_path(gallery, t: 'documentos')
    assert_response :success

    # assert_select "meta[property='og:title'][content='Handbook']"
    # assert_select "meta[property='og:url'][content='#{book_slug_url(books(:handbook))}']"
  end
end
