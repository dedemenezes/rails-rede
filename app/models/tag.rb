class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { minimum: 2 }
end
