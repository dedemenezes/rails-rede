class ArticleTag < ApplicationRecord
  belongs_to :tag
  belongs_to :article
  validates :tag, uniqueness: { scope: :article }
end
