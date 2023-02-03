class Article < ApplicationRecord
  validates :header, :sub_header, presence: true, uniqueness: true
  has_many :article_tags
  has_many :tags, through: :article_tags
  has_one_attached :banner
  has_rich_text :rich_body
end
