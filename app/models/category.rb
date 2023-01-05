class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length:{ minimum: 5 }
  has_many :observatory_categories, dependent: :destroy
  has_many :observatories, through: :observatory_categories
end
