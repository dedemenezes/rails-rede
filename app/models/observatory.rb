class Observatory < ApplicationRecord
  validates :name,
            :email,
            :phone_number,
            :description,
            :address, presence: true

  belongs_to :unity_type, inverse_of: :observatories
  has_one :observatory_category, dependent: :destroy
  has_one :category, through: :observatory_category
  has_one :observatory_conflict, dependent: :destroy
  has_one :conflict_type, through: :observatory_conflict
  has_one :observatory_priority, dependent: :destroy
  has_one :priority_type, through: :observatory_priority
  has_many :members

  has_one_attached :banner
  has_rich_text :rich_description
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  after_create :create_tag

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

  def create_tag
    Tag.create name: self.name
  end
end
