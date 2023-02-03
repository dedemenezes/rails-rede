class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
    authorize @article
  end
end
