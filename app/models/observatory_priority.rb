class ObservatoryPriority < ApplicationRecord
  belongs_to :observatory
  belongs_to :priority_type
end
