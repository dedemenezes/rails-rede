class Article < ApplicationRecord
  validates :header, :sub_header, presence: true, uniqueness: true
  validates :featured, uniqueness: true
  has_one_attached :banner
  has_one_attached :highlight_image
  has_rich_text :rich_body

  scope :main, -> { find_by_featured(true) }
  scope :only_published, -> { where(published: true) }
  scope :all_but_featured, -> { order(created_at: :desc).to_a.delete_if(&:featured) }

  acts_as_taggable_on :tags

  def self.dashboard_headers
    %w[id banner header sub\ header rich\ body featured? published?]
  end

  def self.featured
    find_by_featured(true) || nil
  end

  def self.has_any_present?
    count.positive?
  end

  def published?
    published ? '✅' : '❌'
  end

  def featured?
    featured ? '✅' : '❌'
  end
end
