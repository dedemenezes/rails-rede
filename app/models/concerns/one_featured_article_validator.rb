class OneFeaturedArticleValidator < ActiveModel::Validator
  def validate(record)
    return if record.featured

    featured_articles = record.class.where(featured: true)
    return unless featured_articles.size == 1 && featured_articles.first == record

    record.errors.add :featured, "precisa conter ao menos um"
  end
end
