require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test '#strip_video_id assign correct video_id attrbibute from YouTube full URL' do
    project = Project.new video_id: 'https://www.youtube.com/watch?v=ccuc6dgTec0'
    project.strip_video_id
    assert_equal project.video_id, "ccuc6dgTec0"
  end

  test '#strip_video_id assign correct video_id attrbibute from YouTube shortned URL' do
    project = Project.new video_id: 'https://youtu.be/ccuc6dgTec0'
    project.strip_video_id
    assert_equal project.video_id, "ccuc6dgTec0"
  end
end
