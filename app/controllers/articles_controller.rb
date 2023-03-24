class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_article, only: %i[show]

  def index
    if params[:tags].present?
      tags_ids = Tag.where(name: params[:tags]).map{ |tag| tag.id }
      @articles = policy_scope(Article).joins(:taggings, :tags).where(taggings: { tag_id: tags_ids }).to_a.sort_by(&:updated_at).reverse
      # @featured_article = @articles.select(&:featured).first
      # @featured_article = @articles.first if @featured_article.nil?
      # @recent_articles = @articles.slice!(1, 5)
      # @articles = [] if @articles.size == 1
    else
      @articles = policy_scope(Article).all_but_featured
      @featured_article = Article.featured
      @recent_articles = Article.where(published: true, featured: false).order(updated_at: :desc).limit(4)
      @articles = Article.where(published: true, featured: false).order(updated_at: :desc).offset(4)
    end
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
