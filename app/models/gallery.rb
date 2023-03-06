class Gallery < ApplicationRecord
  belongs_to :observatory, optional: true
  has_many :albuns
end
