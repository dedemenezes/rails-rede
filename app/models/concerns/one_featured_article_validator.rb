class OneFeaturedArticleValidator < ActiveModel::Validator
  def validate(record)
    return if record.featured || record.class.find_by(featured: true) != record

    record.errors.add :featured, "must be checked"
  end
end
