class Album < ApplicationRecord
  CATEGORIES = [['document', 'documento'], ['photo', 'foto']]

  validates :name, presence: true, uniqueness: { scope: :gallery_id }
  validates :category, inclusion: { in: CATEGORIES.map(&:first) }
  # validate :category_must_match_attachment

  belongs_to :gallery
  has_many_attached :photos
  has_many_attached :documents
  has_one_attached :banner
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  scope :only_published_events, -> { where(is_event: true, published: true) }
  # scope :with_documents, -> { joins(:documents_attachments).distinct }
  scope :with_only_photos, -> { left_outer_joins(:documents_attachments).where(documents_attachments: { id: nil }) }

  def set_banner(attach)
    self.banner = attach.blob
  end

  def self.with_photos
    left_joins(:photos_attachments).where(category: 'photo').group(:id)
  end

  def self.published_with_photos
    with_photos.where(published: true).having("COUNT(active_storage_attachments) > 0")
  end

  def self.with_videos
    where(category: 'video')
  end

  def self.published_with_videos
    with_videos.where(published: true)
  end

  def self.with_documents
    # where(category: 'document')
    left_joins(:documents_attachments).where(category: 'document').group(:id)
  end

  def self.published_with_documents
    with_documents.where(published: true).having("COUNT(active_storage_attachments) > 0")
  end

  def self.dashboard_headers
    to_permit = %w[id name]
    attribute_names.select { |a| to_permit.include?(a) }
                   .push(%w[gallery\ name category published updated_at])
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

  # def category_must_match_attachment
  #   return if category.nil?
  #   return unless errors.empty?

  #   ['photo', 'document'].each do |category_default|
  #     if (category == category_default && !self.send("#{category_default}s".to_sym)&.attached?) ||
  #        (self.send("#{category_default}s".to_sym).attached? && category != category_default)
  #       errors.add(:category, "#{category.upcase} must match attachment type")
  #     end
  #   end

  #   if (category == 'video' && videos.empty?) ||
  #       (videos.present? && category != category_default)
  #     errors.add(:category, "VIDEO must match attachment type")
  #   end
  # end
end
