class OneFeaturedArticleValidator < ActiveModel::Validator
  def validate(record)
    unless record.class.find_by(featured: true) || record.featured
      record.errors.add :featured, "must be checked"
    end
  end
end
