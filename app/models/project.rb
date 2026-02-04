class Project < ApplicationRecord
  YOUTUBE_BASE_URL = 'https://www.youtube.com/embed/'
  has_many :methodologies
  has_many :members
  has_many :articles
  has_one_attached :banner
  has_one_attached :slide_one
  has_one_attached :slide_two
  has_one_attached :slide_three
  has_rich_text :content
  validates :banner_text, presence: true, length: { minimum: 53, maximum: 100 }
  before_validation :strip_video_link, if: :will_save_change_to_video_id?
  before_validation :normalize_social_media_urls

  def self.dashboard_headers
    # attribute_names.reject do |a|
    #   ["slide_one_subtitle", "slide_two_subtitle", "slide_three_subtitle"].include?(a)
    # end.insert(1, 'banner')
    ['id', 'banner', 'name', 'updated_at']
  end

  def social_links
    {
      instagram: ig_url.present? ? ig_url : 'pearedeobservacao',
      facebook: fb_url.present? ? fb_url : 'pearedeobservacao',
      youtube: yt_url.present? ? yt_url : '@pearedeobservacao'
    }
  end

  def to_s
    'projects'
  end

  def strip_video_link
    return unless video_id.match?(URI::DEFAULT_PARSER.make_regexp)

    self.video_id = strip_video_id
  end

  def strip_video_id
    return unless video_id.present?

    match_data = video_id.match(%r{(?:(you.+)/)(?:(watch\?\w?=)?)(?<id>\w+)})
    match_data[:id]
  end

  def normalize_social_media_urls
    urls = { yt_url: 'youtube', fb_url: 'facebook', ig_url: 'instagram' }
    urls.each_key do |sm_url|
      sm_attribute_value = send(sm_url)
      next if sm_attribute_value.blank?

      match_data = sm_attribute_value.match(%r{(?:https?://)?(?:www\.)?#{urls[sm_url]}\.com/([a-zA-Z0-9_-]+)})
      send(:"#{sm_url}=", match_data[1]) if match_data
    end
  end
end
