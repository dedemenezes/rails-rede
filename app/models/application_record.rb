class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def create_tags
    Tag.create name: self.address
    Tag.create name: self.conflict_type.name
  end
end
