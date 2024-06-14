class Observatory < ApplicationRecord
  validates :name,
            :email,
            :state, presence: true
  # :municipality,
  validates :municipality, length: { in: 0..3 }
  # validates :zip_code, length: { is: 8 }
  # validates :phone_number, format: { with: /\A(\+5521|0?\d{2})?(\d{8}|\d{9})\z/ }

  belongs_to :unity_type, inverse_of: :observatories

  has_one :observatory_category, dependent: :destroy
  has_one :category, through: :observatory_category
  has_one :observatory_conflict, dependent: :destroy
  has_many :conflict_types, through: :observatory_conflict
  has_one :gallery, dependent: :destroy
  has_many :albums, through: :gallery
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :articles
  has_many :observatory_priority_subjects, dependent: :destroy
  has_many :priority_subjects, through: :observatory_priority_subjects, source: :priority_type

  has_one_attached :banner
  has_rich_text :rich_description
  # geocoded_by :address

  # reverse_geocoded_by :latitude, :longitude do |obj,results|
  #   if geo = results.first
  #     obj.city    = geo.city
  #     obj.zipcode = geo.postal_code
  #     obj.country = geo.country_code
  #   end
  # end

  before_validation :strip_phone_number, :strip_zip_code, :set_address
  # after_validation :geocode
  # after_validation :reverse_geocode

  after_create :set_gallery

  def self.dashboard_headers
    to_permit = ['id', 'name', 'address', 'description', 'created at', 'updated_at']
    attribute_names.select { |a| to_permit.include? a }.push('published').insert(1, 'banner')
  end

  def events
    albums.select { |album| album.is_event && album.published }
  end

  def location
    neighborhood
  end

  def published?
    published ? '✅' : '❌'
  end

  def strip_phone_number
    return unless phone_number

    self.phone_number = phone_number.gsub(/\D/, '').remove(' ')
  end

  def strip_zip_code
    return unless zip_code

    self.zip_code = zip_code.gsub(/\D/, '').remove(' ')
  end

  def set_address
    if street.nil? || street.empty?
      self.address = ''
      return
    end
    self.address = [street, number, city, state].compact.join(', ')
  end

  def to_param
    name
  end
end
