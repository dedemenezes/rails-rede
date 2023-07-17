class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_article, only: %i[show]

  def index
    # binding.b
    if params[:search].present?
      tags = []
      params[:search].each do |_name, dom_id|
        tags << Tag.find(dom_id.split('_').last)
      end
      @articles = policy_scope(Article)
                  .includes(:tags, :rich_text_rich_body)
                  .joins(:taggings, :tags)
                  .where(taggings: { tag_id: tags.map(&:id) })
                  .order(updated_at: :desc)
    else
      @articles = policy_scope(Article.includes(:tags, banner_attachment: :blob))
    end
    @featured = Article.featured
    @articles = @articles.all_but_featured
    @top_four = @articles.limit(4)
    @articles = @articles.offset(4)
  end

  def show
    observatory = @article.observatory
    methodology = @article.methodology
    project = @article.project
    @writer = observatory || methodology || project
    set_article
    authorize @article
    add_breadcrumb @article.model_name.collection.capitalize, '#'
    add_breadcrumb "article_#{@article.id}", '#'
  end

  private

  def set_article
    query = params[:id].present? ? params[:id] : params[:header]
    if query.match?(/[a-zA-Z]+/)
      @article = Article.find_by(header: query)
    else
      @article = Article.find(query)
    end
  end
end
