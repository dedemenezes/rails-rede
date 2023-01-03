class ConflictType < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length:{ minimum: 5 }
end
