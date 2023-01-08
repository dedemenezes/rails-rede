class Observatory < ApplicationRecord
  validates :name, :email, :phone_number, presence: true

  belongs_to :unity_type, inverse_of: :observatories
  has_one :observatory_category, dependent: :destroy
  has_one :category, through: :observatory_category
  has_one :observatory_conflict, dependent: :destroy
  has_one :conflict_type, through: :observatory_conflict
  has_one :observatory_priority, dependent: :destroy
  has_one :priority_type, through: :observatory_priority

  has_one_attached :banner

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end