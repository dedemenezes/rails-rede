class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
    authorize @article
    add_breadcrumb @article.model_name.collection.capitalize, '#'
    add_breadcrumb "article_#{@article.id}", '#'

  end
end
