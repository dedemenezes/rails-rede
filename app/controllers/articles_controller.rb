class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_article, only: %i[show]

  def index
    @articles = policy_scope(Article)
    @tags = Tag.all.order(name: :asc)
    if params[:search].present?
      tag_ids = params[:search].values.map { _1.split('_').last }
      @articles = @articles.includes(:tags, banner_attachment: :blob).joins(:taggings)
                           .where(taggings: { tag_id: tag_ids })
                           .order(updated_at: :desc)
      @featured = @articles.limit(1).first
      @articles = @articles.offset(1)
    else
      @articles = @articles.includes(:tags, banner_attachment: :blob)
      @featured = @articles.featured
    end
    @articles = @articles.all_but_featured
    @top_four = @articles.limit(4)
    @top_four_is_full = @top_four.length > 3
    @articles = @articles.offset(4)
  end

  def show
    observatory = @article.observatory
    methodology = @article.methodology
    project = @article.project
    @writer = observatory || methodology || project
    set_article
    authorize @article
    add_breadcrumb @article.model_name.collection.capitalize, '#'
    add_breadcrumb "article_#{@article.id}", '#'
  end

  private

  def set_article
    query = params[:id].present? ? params[:id] : params[:header]
    if query.match?(/[a-zA-Z]+/)
      @article = Article.find_by(header: query)
    else
      @article = Article.find(query)
    end
  end
end
