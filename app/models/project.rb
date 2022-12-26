class Project < ApplicationRecord
  has_rich_text :content
  has_one_attached :banner
end
