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
  # validates :zip_code, length: { is: 8 }
  validates :phone_number, format: { with: /\A(\+5521|0?21)?\d{9}\z/ }

  belongs_to :unity_type, inverse_of: :observatories
  belongs_to :priority_type

  has_one :observatory_category, dependent: :destroy
  has_one :category, through: :observatory_category
  has_one :observatory_conflict, dependent: :destroy
  has_one :conflict_type, through: :observatory_conflict
  has_one :gallery, dependent: :destroy
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :articles

  has_one_attached :banner
  has_rich_text :rich_description
  geocoded_by :address

  before_validation :strip_phone_number, :strip_zip_code, :set_address
  after_validation :geocode, if: :will_save_change_to_address?

  after_create :set_gallery

  def self.dashboard_headers
    ['id', 'name', 'address', 'description', 'published?', 'created at', 'updated_at']
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
    self.address = [street, number, city, state].compact.join(', ')
  end
end
