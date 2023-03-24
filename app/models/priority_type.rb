class PriorityType < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 5 }
  has_many :observatory_priority_subjects, dependent: :destroy

  def self.dashboard_headers
    %w[id name]
  end
end
