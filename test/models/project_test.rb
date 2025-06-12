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

  test "#normalize_social_urls extracts correct username" do
    project = projects(:one)
    project.update(yt_url: 'pea-rede_observacao')
    assert_equal 'pea-rede_observacao', project.yt_url

    project.update(yt_url: 'www.youtube.com/pea-rede_observacao')
    assert_equal 'pea-rede_observacao', project.yt_url
    project.update(yt_url: 'http://www.youtube.com/pea-rede_observacao')
    assert_equal 'pea-rede_observacao', project.yt_url
    project.update(yt_url: 'https://www.youtube.com/pea-rede_observacao')
    assert_equal 'pea-rede_observacao', project.yt_url
  end
end
