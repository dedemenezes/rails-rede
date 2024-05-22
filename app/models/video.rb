class Video < ApplicationRecord
  validates :url, presence: true
  belongs_to :album
end
