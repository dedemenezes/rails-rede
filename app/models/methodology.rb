class Methodology < ApplicationRecord
  belongs_to :project
  has_rich_text :content
  has_one_attached :banner
  validates :name, presence: true, length: { minimum: 3 }
end
