class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def published?
    self.published ? '✅' : '❌'
  end

  def to_param
    return "#{id}-#{name.parameterize}" if respond_to? :name
    return "#{id}-#{header.parameterize}" if respond_to? :header
  end
end
