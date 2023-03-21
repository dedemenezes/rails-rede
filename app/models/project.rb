class Project < ApplicationRecord
  has_many :methodologies
  has_many :members
  has_one_attached :banner
  has_one_attached :slide_one
  has_one_attached :slide_two
  has_one_attached :slide_three
  has_rich_text :content
  validates :banner_text, presence: true, length: { minimum: 53, maximum: 100 }

  def self.dashboard_headers
    ['id', 'banner', 'name', 'updated at']
  end

  def to_s
    'projects'
  end
end
