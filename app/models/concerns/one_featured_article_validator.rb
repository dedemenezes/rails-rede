class OneFeaturedArticleValidator < ActiveModel::Validator
  def validate(record)
    unless record.featured || record.class.find_by(featured: true) != record
      record.errors.add :featured, "must be checked"
    end
  end
end
