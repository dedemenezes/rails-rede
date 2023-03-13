class Methodology < ApplicationRecord
  belongs_to :project
  has_one :gallery, dependent: :destroy
  has_rich_text :content
  has_one_attached :banner
  validates :name, presence: true, length: { minimum: 3 }

  after_create :set_gallery
end
