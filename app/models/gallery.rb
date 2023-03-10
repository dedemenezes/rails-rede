class Gallery < ApplicationRecord
  validates :name, presence: true
  belongs_to :observatory, optional: true
  has_many :albums, dependent: :destroy
  has_one_attached :banner

  scope :published, -> { where(published: true) }

  def self.dashboard_headers
    %w[id banner name observatory\ name category published?]
  end

  def observatory_name
    observatory&.name
  end

  def albums?
    albums.count.positive?
  end
end
