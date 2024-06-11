module Dashboard
  class ArticlesController < ApplicationController
    layout 'dashboard'

    before_action :set_article, only: %i[edit update]

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
      ArticleWriter.set_article_writer(params, @article)
      SetTags.tagging(@article, params)
      if @article.update(article_params)
        redirect_to dashboard_articles_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @article = Article.find(params[:header])
      @article.destroy
      redirect_to dashboard_articles_path, notice: 'Noticia destruída'
    end

    private

    def set_article
      @article = Article.find_by(header: params[:header])
    end

    def article_params
      params.require(:article).permit(:banner, :header, :sub_header, :rich_body, :featured, :published, :observatory_id,
                                      :methodology_id, :project_id)
    end
  end
end
