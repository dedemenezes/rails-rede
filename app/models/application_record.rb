class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def published?
    published ? '✅' : '❌'
  end

  def not_published?
    published == false
  end

  def set_gallery
    return unless gallery.nil?

    attributes = {}
    attributes[self.class.to_s.downcase.to_sym] = self
    attributes[:name] = name
    Gallery.create attributes
  end
end
