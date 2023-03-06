class Gallery < ApplicationRecord
  belongs_to :observatory, optional: true
  has_many :albums
  has_one_attached :banner

  def self.dashboard_headers
    %w[id banner name observatory\ name category published?]
  end

  def observatory_name
    observatory&.name
  end

  def albums?
    albums.count.positive?
  end
end
