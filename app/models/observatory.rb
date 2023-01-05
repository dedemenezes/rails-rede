class Observatory < ApplicationRecord
  validates :name, :email, :phone_number, :type, presence: true

  belongs_to :unity_type
  has_many :observatory_categories, dependent: :destroy
  has_many :categories, through: :observatory_categories
  has_many :observatory_conflicts, dependent: :destroy
  has_many :observatory_priorities, dependent: :destroy
end
