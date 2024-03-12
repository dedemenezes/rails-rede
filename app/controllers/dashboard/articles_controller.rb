module Dashboard
  class ArticlesController < ApplicationController
    layout 'dashboard'

    before_action :set_article, only: %i[edit destroy]

    def index
      @articles = policy_scope(Article,
                               policy_scope_class: Dashboard::UserPolicy::Scope).includes(banner_attachment: :blob).order(id: :desc)
    end

    def new
      @article = Article.new
    end

    def create
      @article = Article.new(article_params)
      ArticleWriter.set_article_writer(params, @article)
      if @article.save
        SetTags.tagging(@article, params)
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
      ArticleWriter.set_article_writer(params, @article)
      SetTags.tagging(@article, params)
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

    def set_article
      if params[:id].match?(/[a-zA-Z]+/)
        @article = Article.find_by(header: params[:id]) if @article.nil?
      else
        @article = Article.find(params[:id])
      end
    end

    def article_params
      params.require(:article).permit(:banner, :header, :sub_header, :rich_body, :featured, :published, :observatory_id,
                                      :methodology_id, :project_id)
    end
  end
end
