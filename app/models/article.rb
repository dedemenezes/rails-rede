class Article < ApplicationRecord
  # validates :header, length: { maximum: 80 }
  validates :header, presence: true, uniqueness: true
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
  before_validation :ensure_one_featured_article, if: :will_save_change_to_featured?

  scope :only_published, -> { where(published: true).order(featured: 'DESC') }
  scope :all_but_featured, -> { only_published.where.not(featured: true).order(updated_at: :desc) }

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
    includes(:project, :observatory, :methodology).all.select {|a| a.writer == name }
  end

  def writer
    observatory&.name || project&.name || methodology&.name
  end

  def current_writer_type
    type = observatory || project || methodology
    return '' if type.nil?

    type.model_name.to_s.downcase
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

  def clean_header
    return unless header.present? && header.ends_with?('.')

    self.header = header[...-1]
  end

  def featured?
    featured ? '✅' : '❌'
  end

  def ensure_one_featured_article
    return if Article.featured == self
    if featured
      Article.where.not(id: id).update_all featured: false
    end
  end

  def to_param
    header
  end
end
