module Album::Photoable
  extend ActiveSupport::Concern

  included do
    has_many_attached :photos

    scope :with_only_photos, -> { left_outer_joins(:documents_attachments).where(documents_attachments: { id: nil }) }
    scope :with_photos, -> { left_joins(:photos_attachments).where(category: 'photo').group(:id)  }
    scope :published_with_photos, -> { with_photos.where(published: true).having("COUNT(active_storage_attachments) > 0") }

    # def self.with_photos
    #   left_joins(:photos_attachments).where(category: 'photo').group(:id)
    # end

    # def self.published_with_photos
    #   with_photos.where(published: true).having("COUNT(active_storage_attachments) > 0")
    # end

    def has_only_photos?
      documents.empty?
    end

    def number_of_photos
      photos.size
    end
  end
end
