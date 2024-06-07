class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @articles = policy_scope(Article).includes(banner_attachment: :blob)
    @tags = Tag.all.order(name: :asc)
    if params[:search].present?
      tag_ids = params[:search].values.map { _1.split('_').last }
      @articles = @articles.includes(:taggings)
                           .where(taggings: { tag_id: tag_ids })
                           .order(updated_at: :desc)
      @featured = @articles.limit(1).first
      @articles = @articles.offset(1)
    else
      @featured = @articles.featured
    end
    @articles = @articles.all_but_featured
    @top_four = @articles.limit(4)

    @top_four_is_full = @top_four.length > 3
    @articles = @articles.offset(4)

    @tags = Tag.all.order(name: :asc)

  end

  def show
    @article = Article.find_by(header: params[:header])
    observatory = @article.observatory
    methodology = @article.methodology
    project = @article.project
    @writer = observatory || methodology || project
    authorize @article
    add_breadcrumb @article.model_name.collection.capitalize, '#'
    add_breadcrumb "article_#{@article.id}", '#'
  end
end
