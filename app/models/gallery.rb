class Gallery < ApplicationRecord
  belongs_to :observatory, optional: true
  has_many :albuns

  def self.dashboard_headers
    %w[id name observatory\ name category]
  end

  def observatory_name
    observatory.name
  end
end
