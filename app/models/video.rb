class Video < ApplicationRecord
  URL_REGEX = %r{\A((?<protocol>https?):\/\/(?<www>w{3})?|w{3})\.?(?<host>\w+\.\w{2,3}(\.\w{2})?)(?<path>\/(?<_>watch\?v=)?(?<video_id>\w+).*)?\z}

  validates :url, presence: true
  validates :url, format: { with: URL_REGEX }
  belongs_to :album

  before_validation :strip_url, :set_yt_id

  def self.dashboard_headers
    [:id, :url, :name, :gallery, :published, :updated_at]
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
