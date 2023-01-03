class ObservatoryCategory < ApplicationRecord
  belongs_to :observatory
  belongs_to :category
end
