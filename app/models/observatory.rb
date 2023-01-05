class Observatory < ApplicationRecord
  validates :name, :email, :phone_number, presence: true

  belongs_to :unity_type, inverse_of: :observatories
  has_many :observatory_categories, dependent: :destroy
  has_many :categories, through: :observatory_categories
  has_many :observatory_conflicts, dependent: :destroy
  has_many :observatory_priorities, dependent: :destroy

  has_one_attached :banner
end
