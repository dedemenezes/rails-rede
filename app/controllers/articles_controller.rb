class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @articles = policy_scope(Article).includes(:tags, banner_attachment: :blob)
    @tags = Tag.all.order(name: :asc)
    if params[:search].present?
      tag_ids = params[:search].values.map { _1.split('_').last }
      @articles = @articles.includes(:taggings)
                           .where(taggings: { tag_id: tag_ids })
                           .order(created_at: :desc)
      @featured = @articles.limit(1).first
      @articles = @articles.offset(1)
      @top_four = @articles.limit(4)
      @articles = @articles.offset(5)
    else
      @featured = @articles.main_featured
      # @articles = @articles.all_but_featured
      @top_four = @articles.all_featured
      @articles = Article.includes(:tags, banner_attachment: :blob)
                         .excluding_featured_and_recents(@top_four.pluck(:id).push(@featured&.id))
                         .order(created_at: :desc)
    end
    # raise
    @top_four_is_full = @top_four.length > 3
    @tags = Tag.all.order(name: :asc)
  end

  def show
    if params[:slug].match?(/^\d+-./)
      @article = Article.find(params[:slug])
    else
      @article = Article.find_by_header(params[:slug])
    end
    observatory = @article.observatory
    methodology = @article.methodology
    project = @article.project
    @writer = observatory || methodology || project
    authorize @article
    add_breadcrumb @article.model_name.collection.capitalize, '#'
    add_breadcrumb "article_#{@article.id}", '#'
  end
end
