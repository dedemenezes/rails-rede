class UnityType < ApplicationRecord
  has_many :observatories, inverse_of: :unity_type
end
