class Album < ApplicationRecord
  include Documentable
  include Photoable
  include Taggable

  CATEGORIES = [['document', 'documento'], ['photo', 'foto'], ['video', 'video']]
  HEADERS = %w[id banner name gallery\ name category published updated_at]

  validates :name, presence: true, uniqueness: { scope: :gallery_id }
  validates :category, inclusion: { in: CATEGORIES.map(&:first) }

  belongs_to :gallery
  has_many :videos, dependent: :destroy
  accepts_nested_attributes_for :videos

  has_one_attached :banner

  scope :only_published_events, -> { where(is_event: true, published: true) }
  scope :with_videos, -> { where(category: 'video') }
  scope :published_with_videos, -> { with_videos.where(published: true) }

  delegate :name, to: :gallery, prefix: true, allow_nil: true


  def self.dashboard_headers
    HEADERS
  end

  # ?? UNUSED ??
  def set_banner(attach)
    self.banner = attach.blob
  end

  # UNUSED?
  def pdf?(attachment)
    attachment.blob.content_type =~ /pdf/ && attachment.blob.filename.to_s =~ /.pdf/
  end

  def to_param
    name
  end
end
