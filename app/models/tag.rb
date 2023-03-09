class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { minimum: 2 }

  def self.dashboard_headers
    %w[name total\ de\ tags]
  end

  def total_de_tags
    taggings.count
  end
end
