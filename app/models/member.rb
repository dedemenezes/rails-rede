class Member < ApplicationRecord
  belongs_to :observatory, optional: true
  belongs_to :project, optional: true
end
