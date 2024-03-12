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
  before_validation :strip_video_link

  def self.dashboard_headers
    attribute_names.reject do |a|
      ["slide_one_subtitle", "slide_two_subtitle", "slide_three_subtitle"].include?(a)
    end.insert(1, 'banner')
    # ['id', 'banner', 'name', 'updated at']
  end

  def to_s
    'projects'
  end

  def strip_video_link
    self.video_id = strip_video_id
  end

  def strip_video_id
    return unless video_id.present?

    match_data = video_id.match(%r{(?:(you.+)/)(?:(watch\?\w?=)?)(?<id>\w+)})
    match_data[:id]
  end
end
