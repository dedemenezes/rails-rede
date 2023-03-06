class Observatory < ApplicationRecord
  validates :name,
            :email, presence: true

  belongs_to :unity_type, inverse_of: :observatories
  has_one :observatory_category, dependent: :destroy
  has_one :category, through: :observatory_category
  has_one :observatory_conflict, dependent: :destroy
  has_one :conflict_type, through: :observatory_conflict
  has_one :observatory_priority, dependent: :destroy
  has_one :priority_type, through: :observatory_priority
  has_many :members
  has_many :galleries

  has_one_attached :banner
  has_rich_text :rich_description
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  after_validation :geocode, if: :will_save_change_to_address?

  after_create :set_gallery

  def self.dashboard_headers
    ['id', 'name', 'address', 'description', 'category name', 'published?', 'created at', 'updated_at']
  end

  def published?
    published ? '✅' : '❌'
  end

  def category_name
    return '-' unless category?

    category.name
  end

  def category?
    category.present?
  end

  def set_gallery
    Gallery.create observatory: self, name: self.name
  end
end
