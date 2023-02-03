class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def create_tag
    Tag.create name: self.name
  end
end
