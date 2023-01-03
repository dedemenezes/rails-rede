class ObservatoryConflict < ApplicationRecord
  belongs_to :observatory
  belongs_to :conflict_type
end
