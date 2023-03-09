class Dashboard::ArticlesController < ApplicationController
  layout 'dashboard'

  before_action :set_article, only: %i[edit update destroy]

  def index
    @articles = policy_scope(Article, policy_scope_class: Dashboard::UserPolicy::Scope).order(id: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    create_taggings
    if @article.save
      redirect_to dashboard_articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    destroy_taggings
    create_taggings
    if @article.update(article_params)
      redirect_to dashboard_articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to dashboard_articles_path, notice: 'Noticia destruída'
  end

  private

  def create_taggings
    return unless params[:article][:tag_ids].present?

    tags = Tag.where(id: params[:article][:tag_ids])
    tags.each do |tag|
      Tagging.create tag: tag, taggable: @article
    end
  end

  def destroy_taggings
    return unless params[:article][:tag_ids].count - 1 < @article.taggings.count

    @article.taggings.each do |tagging|
      tagging.destroy unless params[:article][:tag_ids].include? tagging.tag.id.to_s
    end
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:banner, :header, :sub_header, :rich_body, :featured, :published, :observatory_id)
  end
end
