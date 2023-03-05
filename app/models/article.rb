class Article < ApplicationRecord
  validates :header, :sub_header, presence: true, uniqueness: true
  has_many :article_tags
  has_many :tags, through: :article_tags
  has_one_attached :banner
  has_one_attached :highlight_image
  has_rich_text :rich_body

  scope :main, -> { find_by_featured(true) }
  scope :all_but_featured, -> { order(created_at: :desc).to_a.delete_if(&:featured) }

  def self.dashboard_headers
    %w[id banner header sub\ header rich\ body]
  end
end
