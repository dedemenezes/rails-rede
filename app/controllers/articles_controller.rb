class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @has_article = policy_scope(Article)
    @top_article = Article.main if @has_article
    @articles = policy_scope(Article).all_but_featured if @has_article
    @recent_articles = @articles.slice!(0, 4) if @has_article
  end

  def show
    @observatory = Observatory.first
    @article = Article.find(params[:id])
    authorize @article
    add_breadcrumb @article.model_name.collection.capitalize, '#'
    add_breadcrumb "article_#{@article.id}", '#'
  end
end
