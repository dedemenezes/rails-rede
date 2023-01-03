class Observatory < ApplicationRecord
  OBSERVATORY_TYPES = ['observatory', 'platform', 'fpso']
  validates :name, :email, :phone_number, :type, presence: true
  validates :type, inclusion: { in: OBSERVATORY_TYPES}
  has_many :observatory_categories, dependent: :destroy
  has_many :observatory_conflicts, dependent: :destroy
  has_many :observatory_priorities, dependent: :destroy
end
