require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test '#strip_video_id extracts correct ID from YouTube full URL' do
    project = Project.new(video_id: 'https://www.youtube.com/watch?v=ccuc6dgTec1')
    assert_equal 'ccuc6dgTec1', project.strip_video_id
  end

  test '#strip_video_id extracts correct ID from YouTube shortened URL' do
    project = Project.new(video_id: 'https://youtu.be/ccuc6dgTec2')
    assert_equal 'ccuc6dgTec2', project.strip_video_id
  end
end
