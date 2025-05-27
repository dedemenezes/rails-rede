require "test_helper"

class Dashboard::AlbumsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:coppola)
  end

  test "should create an album with videos" do
    gallery = galleries(:video_gallery)
    valid_params = {
      "album" => {
        "name" => "TEST Video Album",
        "gallery_id" => gallery.id,
        "category" => "video",
        "videos_attributes" => {
          "0" => {
            "name" => "TEST video one SHORTEST VIDEO",
            "description" => "Here is the first video description",
            "url" => "https://www.youtube.com/watch?v=tPEE9ZwTmy0"
          },
          "1" => {
            "name" => "TEST video TWO",
            "description" => "Here is the second video description",
            "url" => "https://www.youtube.com/watch?v=-FTNbqxCfhA"
          }
        }
      }
    }

    assert_difference 'Album.count', 1 do
      post dashboard_albums_url, params: valid_params
    end
    assert_response :redirect
    assert_equal 2, Album.last.videos.size
  end
end
