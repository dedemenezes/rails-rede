require 'test_helper'

class VideoCallbackTest < ActiveSupport::TestCase
  fixtures :videos

  test 'after_validation sets yt_id correctly for valid URLs' do
    video = videos(:still_one)
    video.valid?  # triggers callbacks
    assert_equal '_CL6n0FJZpk', video.yt_id
  end

  test 'after_validation does not set yt_id for invalid URLs' do
    video = videos(:still_one)
    video.url = 'invalid-url'
    video.valid?
    assert_nil video.yt_id
  end

  test 'before_validation strips url from trailing spaces' do
    video = videos(:still_one)
    video.url = " \n https://www.youtube.com/watch?v=_CL6n0FJZpk  \n"
    video.valid?
    assert_equal 'https://www.youtube.com/watch?v=_CL6n0FJZpk', video.url
  end
end
