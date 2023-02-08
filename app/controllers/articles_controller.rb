class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!
  def show
    @observatory = Observatory.first
    @article = Article.find(params[:id])
    authorize @article
    add_breadcrumb @article.model_name.collection.capitalize, '#'
    add_breadcrumb "article_#{@article.id}", '#'
  end
end
