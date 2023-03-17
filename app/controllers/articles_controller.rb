class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if params[:tags].present?
      # raise
      tags_ids = Tag.where(name: params[:tags]).map{ |tag| tag.id }
      @articles = policy_scope(Article).joins(:taggings, :tags).where(taggings: { tag_id: tags_ids }).to_a
      @featured_article = @articles.select(&:featured).first
      @featured_article = @articles.first if @featured_article.nil?
      @recent_articles = @articles.slice!(1, 5)
      @articles = [] if @articles.size == 1
    else
      @articles = policy_scope(Article).all_but_featured
      @featured_article = Article.featured
    @recent_articles = @articles.slice!(0, 4)
    end
  end

  def show
    @observatory = Observatory.first
    set_article
    authorize @article
    add_breadcrumb @article.model_name.collection.capitalize, '#'
    add_breadcrumb "article_#{@article.id}", '#'
  end

  private

  def set_article
    begin
      @article =  Article.find_by(header: params[:header])
    rescue => exception
      @article = Article.find(params[:id])
    end
  end
end
