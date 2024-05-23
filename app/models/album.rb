class Album < ApplicationRecord
  validates :name, uniqueness: { scope: :gallery }
  belongs_to :gallery
  has_many_attached :photos
  has_many_attached :documents
  has_one_attached :banner
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :videos
  accepts_nested_attributes_for :videos

  scope :only_published_events, -> { where(is_event: true, published: true) }
  scope :with_documents, -> { joins(:documents_attachments).distinct }
  scope :with_only_photos, -> { left_outer_joins(:documents_attachments).where(documents_attachments: { id: nil }) }

  def set_banner(attach)
    self.banner = attach.blob
  end

  def self.dashboard_headers
    to_permit = %w[id name]
    attribute_names.select { |a| to_permit.include?(a) }
                   .push(%w[gallery\ name published updated_at])
                   .flatten
                   .insert(1, 'banner')
  end

  def has_only_photos?
    documents.empty?
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
