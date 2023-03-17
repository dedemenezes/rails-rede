class Article < ApplicationRecord
  validates :header, :sub_header, presence: true, uniqueness: true
  validates_with OneFeaturedArticleValidator

  belongs_to :observatory, optional: true
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings
  has_one_attached :banner
  has_one_attached :highlight_image
  has_rich_text :rich_body

  after_validation :ensure_one_featured_article

  scope :only_published, -> { where(published: true) }
  scope :all_but_featured, -> { order(created_at: :desc).to_a.delete_if(&:featured) }

  # acts_as_taggable_on :tags

  def self.dashboard_headers
    %w[id banner header tags\ name featured? published? observatory\ name]
  end

  def self.featured
    find_by_featured(true) || nil
  end

  def observatory_name
    observatory&.name
  end

  def tags_name
    return '' if tags.empty?
    return tags[0].name unless tags.count > 1

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

  def to_param
    header
  end
end
