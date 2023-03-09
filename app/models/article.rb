class Article < ApplicationRecord
  validates :header, :sub_header, presence: true, uniqueness: true
  validates_with OneFeaturedArticleValidator

  has_one_attached :banner
  has_one_attached :highlight_image
  has_rich_text :rich_body
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  after_validation :ensure_one_featured_article

  scope :only_published, -> { where(published: true) }
  scope :all_but_featured, -> { order(created_at: :desc).to_a.delete_if(&:featured) }

  # acts_as_taggable_on :tags

  def self.dashboard_headers
    %w[id banner header tags\ name featured? published?]
  end

  def self.featured
    find_by_featured(true) || nil
  end

  def tags_name
    names = tags.map(&:name)
    "#{names[0...-1].join(', ')} e #{names[-1]}"
  end

  def self.any_present?
    count.positive?
  end

  def featured?
    featured ? '✅' : '❌'
  end

  def ensure_one_featured_article
    return if Article.featured.nil?
    return unless featured

    Article.featured.update(featured: false)
    self.featured = true
  end
end
