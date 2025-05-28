class Article < ApplicationRecord
  HEADER_MAX_SIZE = 113
  validates :header, presence: true, uniqueness: true, length: { maximum: HEADER_MAX_SIZE }

  validates_with OneFeaturedArticleValidator
  validates_with MustHaveAWriter

  belongs_to :observatory, optional: true
  belongs_to :methodology, optional: true
  belongs_to :project, optional: true
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings
  has_one_attached :banner
  has_one_attached :highlight_image
  has_rich_text :rich_body

  before_validation :clean_header

  before_save :ensure_no_more_than_three_featured_article, if: :saved_change_to_featured?
  after_save :update_featured_at, if: :saved_change_to_featured?
  after_create :set_featured_if_none
  after_destroy :promote_latest_updated_if_featured_none

  scope :only_published, -> { where(published: true).order(featured: 'DESC') }
  scope :all_featured, -> { where(featured: true).order(featured_at: :desc) }
  scope :all_but_featured, -> { only_published.where.not(featured: true).order(updated_at: :desc) }

  delegate :visible_tags, to: :taggings
  # acts_as_taggable_on :tags

  def self.dashboard_headers
    to_permit = %w[id header]
    attribute_names.select { |a| to_permit.include?(a) }.push(%w[featured? published]).flatten.insert(1, 'banner')
  end

  def self.featured
    find_by_featured(true) || nil
  end

  def self.any_present?
    count.positive?
  end

  def self.find_by_writer(name)
    includes(:project, :observatory, :methodology).all.select { |a| a.writer == name }
  end

  def writer
    observatory&.name || project&.name || methodology&.name
  end

  def current_writer_type
    type = observatory || project || methodology
    return '' if type.nil?

    type.model_name.to_s.downcase
  end

  delegate :name, to: :observatory, prefix: true, allow_nil: true
  # def observatory_name
  #   observatory&.name
  # end

  # NEVER USED
  # def tags_name
  #   return '' if tags.empty?
  #   return tags[0].name unless tags.count > 1

  #   names = tags.map(&:name)
  #   "#{names[0...-1].join(', ')} e #{names[-1]}"
  # end

  def clean_header
    return unless header.present? && header.ends_with?('.')

    self.header = header[...-1]
  end

  def featured?
    featured ? '✅' : '❌'
  end

  def ensure_no_more_than_three_featured_article
    if featured && Article.where(featured: true).size > 3
      oldest_featured = Article.where(featured: true).order(featured_at: :asc).first
      oldest_featured.update(featured: false)
    end
  end

  def to_param
    "#{id}-#{header.parameterize}"
  end

  private

  def set_featured_if_none
    unless Article.exists?(featured: true)
      update(featured: true)
    end
  end

  def promote_latest_updated_if_featured_none
    if self.featured && Article.where(featured: true).empty?
      article = Article.order(updated_at: :desc).first
      article.update(featured: true)
    end
  end

  def update_featured_at
    return unless featured

    self.featured_at = self.updated_at
    self.save
  end
end
