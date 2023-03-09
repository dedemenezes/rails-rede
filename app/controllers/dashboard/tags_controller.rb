class Dashboard::TagsController < ApplicationController
  layout 'dashboard'
  before_action :set_tag, except: %i[index new create]

  def index
    @tags = Tag.all.order(created_at: :desc)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to dashboard_tags_path, notice: 'Tag criada'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to dashboard_tags_path, notice: 'Tag atualizada'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @tag.destroy
      redirect_to dashboard_tags_path
    else
      redirect_to dashboard_tags_path, alert: 'Tag não foi removida'
    end
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
