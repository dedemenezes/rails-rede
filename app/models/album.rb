class Album < ApplicationRecord
  belongs_to :gallery
  has_many_attached :photos
  has_one_attached :banner
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  scope :only_published_events, -> { where(is_event: true, published: true) }


  def set_banner(attach)
    self.banner = attach.blob
  end

  def self.dashboard_headers
    to_permit = %w[id name number\ of\ photos gallery\ name]
    attribute_names.select { |a| to_permit.include?(a) }.push('published').insert(1, 'banner')
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
