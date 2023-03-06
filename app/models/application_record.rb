class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def published?
    self.published ? '✅' : '❌'
  end
end
