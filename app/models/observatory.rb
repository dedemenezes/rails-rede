class Observatory < ApplicationRecord
  validates :name,
            :email,
            :phone_number,
            :street,
            :number,
            :city,
            :state,
            :zip_code,
            :neighborhood, presence: true
  validates :municipality, length: { in: 2..3 }
  validates :zip_code, length: { is: 8 }
  validates :phone_number, format: { with: /\A(\+5521|0?21)?\d{9}\z/ }

  belongs_to :unity_type, inverse_of: :observatories
  belongs_to :priority_type

  has_one :observatory_category, dependent: :destroy
  has_one :category, through: :observatory_category
  has_one :observatory_conflict, dependent: :destroy
  has_one :conflict_type, through: :observatory_conflict
  has_many :galleries, dependent: :destroy
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  has_one_attached :banner
  has_rich_text :rich_description
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude

  before_validation :strip_phone_number, :strip_zip_code
  after_validation :reverse_geocode
  after_validation :geocode, if: :will_save_change_to_address?

  after_create :set_gallery

  def self.dashboard_headers
    ['id', 'name', 'address', 'description', 'category name', 'published?', 'created at', 'updated_at']
  end

  def location
    "#{street}"
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

  def strip_phone_number
    self.phone_number = phone_number.gsub(/\D/, '').remove(' ')
  end

  def strip_zip_code
    self.zip_code = zip_code.gsub(/\D/, '').remove(' ')
  end
end
