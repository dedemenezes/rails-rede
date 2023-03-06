class Gallery < ApplicationRecord
  belongs_to :observatory, optional: true
  has_many :albums

  def self.dashboard_headers
    %w[id name observatory\ name category published?]
  end

  def observatory_name
    observatory&.name
  end

  def albums?
    albums.count.positive?
  end
end
