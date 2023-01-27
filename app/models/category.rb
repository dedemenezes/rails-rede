class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length:{ minimum: 5 }
  has_many :observatory_categories, dependent: :destroy
  has_many :observatories, through: :observatory_categories
  has_one_attached :banner
  has_rich_text :rich_body

  def self.dashboard_headers
    ['id', 'name', 'updated at', 'created at']
  end
end
