class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
  validates :tag, uniqueness: { scope: :taggable }

  scope :visble_tags, -> { where(visible: true).map(&:tag) }
end
