module ArticleWriter
  def self.set_article_writer(params, article)
    set_project(params, article) || set_observatory(params, article) || set_methodology(params, article)
  end

  def self.set_methodology(params, article)
    return unless params[:article][:methodology_id].present?

    article.project = nil
    article.observatory = nil
    methodology = Methodology.find(params[:article][:methodology_id])
    article.methodology = methodology
  end

  def self.set_project(params, article)
    return unless params[:article][:project_id].present?

    article.methodology = nil
    article.observatory = nil
    project = Project.find(params[:article][:project_id])
    article.project = project
  end

  def self.set_observatory(params, article)
    return unless params[:article][:observatory_id].present?

    article.methodology = nil
    article.project = nil
    observatory = Observatory.find(params[:article][:observatory_id])
    article.observatory = observatory
  end
end
