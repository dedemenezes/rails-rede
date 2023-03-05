class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @top_article = Article.main
    @articles = policy_scope(Article).all_but_featured
    @recent_articles = @articles.slice!(0, 4)
  end

  def show
    @observatory = Observatory.first
    @article = Article.find(params[:id])
    authorize @article
    add_breadcrumb @article.model_name.collection.capitalize, '#'
    add_breadcrumb "article_#{@article.id}", '#'
  end
end
