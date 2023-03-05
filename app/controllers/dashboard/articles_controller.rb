class Dashboard::ArticlesController < ApplicationController
  layout 'dashboard'

  def index
    @articles = policy_scope(Article, policy_scope_class: Dashboard::UserPolicy::Scope)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to dashboard_articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:banner, :header, :sub_header, :rich_body)
  end

end
