class Dashboard::ArticlesController < ApplicationController
  layout 'dashboard'

  before_action :set_article, only: %i[edit destroy]

  def index
    @articles = policy_scope(Article, policy_scope_class: Dashboard::UserPolicy::Scope).order(id: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if params[:article][:project_id].present?
      @project = Project.find(params[:article][:project_id])
      @article.project = @project
    end

    if params[:article][:observatory_id].present?
      @observatory = Observatory.find(params[:article][:observatory_id])
      @article.observatory = @observatory
    end

    if params[:article][:methodology_id].present?
      @methodology = Methodology.find(params[:article][:methodology_id])
      @article.methodology = @methodology
    end

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
    # MUDAR URGENTE
    @article = Article.find_by(header: params[:id])
    # raise
    set_article_writer

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

  def set_article_writer
    set_project || set_observatory || set_methodology
  end

  def set_methodology
    return unless params[:article][:methodology_id].present?

    @article.project = nil
    @article.observatory = nil
    @methodology = Methodology.find(params[:article][:methodology_id])
    @article.methodology = @methodology
  end

  def set_project
    return unless params[:article][:project_id].present?
    binding.break
    @article.methodology = nil
    @article.observatory = nil
    @project = Project.find(params[:article][:project_id])
    @article.project = @project
  end

  def set_observatory
    return unless params[:article][:observatory_id].present?

    @article.methodology = nil
    @article.observatory = nil
    @observatory = Observatory.find(params[:article][:observatory_id])
    @article.observatory = @observatory
  end

  def create_taggings
    return unless params[:article][:tag_ids].present?

    tags = Tag.where(id: params[:article][:tag_ids])
    tags.each do |tag|
      Tagging.create tag: tag, taggable: @article
    end
  end

  def destroy_taggings
    return unless params[:article][:tag_ids]
    return unless params[:article][:tag_ids].count - 1 < @article.taggings.count

    @article.taggings.each do |tagging|
      tagging.destroy unless params[:article][:tag_ids].include? tagging.tag.id.to_s
    end
  end

  def set_article
    if params[:id].match?(/[a-zA-Z]+/)
      @article = Article.find_by(header: params[:id]) if @article.nil?
    else
      @article = Article.find(params[:id])
    end
  end

  def article_params
    params.require(:article).permit(:banner, :header, :sub_header, :rich_body, :featured, :published, :observatory_id, :methodology_id, :project_id)
  end
end
