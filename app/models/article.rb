class Article < ApplicationRecord
  validates :header, :sub_header, presence: true, uniqueness: true
  has_one_attached :banner
  has_rich_text :rich_body
end
