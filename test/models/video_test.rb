require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  # fixtures :videos, :albums

  test 'should belong to album (optional)' do
    reflection = Video.reflect_on_association(:album)
    assert_equal :belongs_to, reflection.macro
    assert reflection.options[:optional], 'Album association should be optional'
  end

  test '::published returns only published videos' do
    still_one = videos(:still_one)
    still_one.update!(published: false)
    assert_equal 0, Video.published.count

    still_two = videos(:still_two)
    still_two.update!(published: true)
    assert_equal 1, Video.published.count
    assert_includes Video.published, still_two
    refute_includes Video.published, still_one
  end

  test '#thumbnail returns correct youtube url' do
    video = videos(:still_one)
    video.update!(yt_id: '_CL6n0FJZpk')
    expected_url = 'https://img.youtube.com/vi/_CL6n0FJZpk/hqdefault.jpg'
    assert_equal expected_url, video.thumbnail
  end
end
