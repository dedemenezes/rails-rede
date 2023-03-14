class Methodology < ApplicationRecord
  belongs_to :project
  has_rich_text :content
  has_one_attached :banner
  has_one_attached :banner_two
  has_one :gallery, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3 }
end
