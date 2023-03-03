class Dashboard::ArticlesController < ApplicationController
  layout 'dashboard'
  def index
    @articles = Article.all
  end
end
