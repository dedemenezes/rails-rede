class Methodology < ApplicationRecord
  belongs_to :project
  has_one :gallery, dependent: :destroy
  has_rich_text :content
  has_one_attached :banner
  has_one_attached :banner_two
  has_one :gallery, dependent: :destroy
  has_many :articles
  validates :name, presence: true, length: { minimum: 3 }
  validates :card_description, presence: true

  after_create :set_gallery

  def self.dashboard_headers
    # to_reject = attribute_names
    to_permit = %w[id name updated_at]
    attribute_names.select { |a| to_permit.include?(a) }.insert(1, 'banner')
    # %w[id banner name created\ at updated\ at]
  end

  def to_param
    name
  end
end
