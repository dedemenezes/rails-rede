class Project < ApplicationRecord
  has_many :methodologies, dependent: :destroy
  has_many :members
  has_one_attached :banner
  has_rich_text :content

  def self.dashboard_headers
    ['id', 'name', 'created at', 'updated at']
  end
end
