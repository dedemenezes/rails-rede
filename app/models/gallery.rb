class Gallery < ApplicationRecord
  validates :name, presence: true
  belongs_to :observatory, optional: true
  belongs_to :methodology, optional: true
  has_many :albums, dependent: :destroy
  has_one_attached :banner
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  scope :published, -> { where(published: true) }
  scope :only_events, -> { where(is_event: true) }

  def self.dashboard_headers
    %w[id banner name category total\ de\ albuns published?]
  end

  def observatory_name
    observatory&.name
  end

  def category
    if observatory.present?
      observatory.model_name.singular.capitalize
    elsif methodology.present?
      methodology.model_name.singular.capitalize
    elsif is_event
      'Event'
    else
      '-'
    end
  end

  def albums?
    albums.count.positive?
  end

  def total_de_albuns
    albums.count
  end

  def observatory?
    observatory.present?
  end

  def to_param
    name
  end
end
