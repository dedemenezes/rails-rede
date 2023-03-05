class Dashboard::ArticlesController < ApplicationController
  layout 'dashboard'

  def index
    @articles = policy_scope(Article, policy_scope_class: Dashboard::UserPolicy::Scope).order(id: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.tag_list.add(params[:article][:tag_list])
    if @article.save
      redirect_to dashboard_articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to dashboard_articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:banner, :header, :sub_header, :rich_body, :featured, :published)
  end

end
