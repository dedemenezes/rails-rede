class Video < ApplicationRecord
  URL_REGEX = %r{\A((?<protocol>https?)://(?<www>w{3})?|w{3})\.?(?<host>\w+\.\w{2,3}(\.\w{2})?)(?<path>/(?<_>watch\?v=)?(?<video_id>\w+).*)?\z}

  belongs_to :album, optional: true

  validates :url, :name, presence: true
  validates :name, length: { minimum: 3 }
  validates :url, format: { with: URL_REGEX }

  before_validation :strip_url
  after_validation :set_yt_id

  scope :published, -> { where(published: true) }

  def self.dashboard_headers
    %w[id thumbnail url name description published updated_at]
  end

  def thumbnail
    return '' unless yt_id.present?

    "https://img.youtube.com/vi/#{yt_id}/hqdefault.jpg"
  end

  private

  def set_yt_id
    return unless url

    match_data = url.match(URL_REGEX)
    self.yt_id = match_data[:video_id] if match_data && match_data[:video_id]
  end

  def strip_url
    return unless url

    self.url = url.strip
  end
end
