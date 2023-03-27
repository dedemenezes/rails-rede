class PriorityType < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 5 }
  has_many :observatory_priority_subjects, dependent: :destroy

  def self.dashboard_headers
    %w[id name updated_at_readable]
  end

  def updated_at_readable
    updated_at.strftime('%d/%m/%y às %H:%M:%S')
  end
end
