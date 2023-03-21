class Album < ApplicationRecord
  belongs_to :gallery
  has_many_attached :photos
  has_one_attached :banner
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  scope :only_events, -> { where(is_event: true) }


  def set_banner(attach)
    self.banner = attach.blob
  end

  def self.dashboard_headers
    %w[id banner name number\ of\ photos gallery\ name published?]
  end

  def number_of_photos
    photos.size
  end

  def gallery_name
    gallery.name
  end

  def pdf?(attachment)
    attachment.blob.content_type =~ /pdf/ && attachment.blob.filename.to_s =~ /.pdf/
  end

  def to_param
    name
  end
end
