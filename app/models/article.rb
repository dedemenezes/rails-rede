class Article < ApplicationRecord
  validates :header, :sub_header, presence: true, uniqueness: true
  has_one_attached :banner
  has_one_attached :highlight_image
  has_rich_text :rich_body

  scope :main, -> { find_by_featured(true) }
  scope :all_but_featured, -> { order(created_at: :desc).to_a.delete_if(&:featured) }

  acts_as_taggable_on :tags

  def self.dashboard_headers
    %w[id banner header sub\ header rich\ body]
  end
end
