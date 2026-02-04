module Album
  module Documentable
    extend ActiveSupport::Concern

    included do
      has_many_attached :documents

      scope :with_documents, -> { left_joins(:documents_attachments).where(category: 'document').group(:id) }
      scope :published_with_documents, lambda {
        with_documents.where(published: true).having("COUNT(active_storage_attachments) > 0")
      }
    end
  end
end
