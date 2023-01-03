class Project < ApplicationRecord
  has_one_attached :banner
  has_rich_text :content
  has_many :methodologies, dependent: :destroy
end
