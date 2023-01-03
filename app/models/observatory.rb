class Observatory < ApplicationRecord
  has_many :observatory_categories, dependent: :destroy
  has_many :observatory_conflicts, dependent: :destroy
  has_many :observatory_priorities, dependent: :destroy
end
