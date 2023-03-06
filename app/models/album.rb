class Album < ApplicationRecord
  belongs_to :gallery
  has_many_attached :photos

  def self.dashboard_headers
    %w[id number_of_photos]
  end

  def number_of_photos
    photos.size
  end
end
