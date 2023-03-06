class Album < ApplicationRecord
  belongs_to :gallery
  has_many_attached :photos
  has_one_attached :banner


  def set_banner(attach)
    self.banner = attach.blob
  end

  def self.dashboard_headers
    %w[id number\ of\ photos gallery\ name]
  end

  def number_of_photos
    photos.size
  end

  def gallery_name
    gallery.name
  end
end
