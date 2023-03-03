class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @articles = policy_scope(Article).order(created_at: :desc)
    @top_article = @articles.first
    @recent_articles = @articles.slice(1, 4)
  end

  def show
    @observatory = Observatory.first
    @article = Article.find(params[:id])
    authorize @article
    add_breadcrumb @article.model_name.collection.capitalize, '#'
    add_breadcrumb "article_#{@article.id}", '#'
  end
end
