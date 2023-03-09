class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
  validates :tag, uniqueness: { scope: :taggable }
end
