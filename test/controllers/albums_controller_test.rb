require "test_helper"

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    album = albums(:published_with_one_photo)
    get album_path(album)
    assert_response :success
  end
end
