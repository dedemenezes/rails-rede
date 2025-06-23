require 'test_helper'

class VideoValidationTest < ActiveSupport::TestCase
  test 'validates presence of url' do
    video = Video.new
    assert video.invalid?
    assert_includes video.errors, :url
    assert_includes video.errors.full_messages, 'Url não é válido'
  end

  test 'validates url format as invalid' do
    invalid_urls = ['htt://www.flamengo.com', 'ww.flamengo.com']
    invalid_urls.each do |invalid_url|
      video = Video.new(url: invalid_url)
      assert video.invalid?, "#{invalid_url} should be invalid"
      assert_includes video.errors, :url
      assert_includes video.errors.full_messages, 'Url não é válido'
    end
  end

  test 'validates url format as valid' do
    valid_urls = [
      'www.flamengo.com.br',
      'http://www.flamengo.com',
      'https://www.flamengo.com',
      'https://flamengo.com.br'
    ]
    valid_urls.each do |url|
      video = Video.new(url: url)
      video.valid?
      refute_includes video.errors, :url, "#{url} should be valid"
    end
  end

  test 'sets youtube video id on valid video' do
    video = videos(:still_one)
    video.valid?
    assert_equal '_CL6n0FJZpk', video.yt_id
  end

  test 'strips url before validation' do
    video = Video.new(url: '         www.flamengo.com         ')
    video.valid?
    assert_equal 'www.flamengo.com', video.url
  end
end
