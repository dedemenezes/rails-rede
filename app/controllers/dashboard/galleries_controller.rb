class Dashboard::GalleriesController < ApplicationController
  layout 'dashboard'

  before_action :set_gallery, only: %i[edit update destroy]

  def index
    @galleries = Gallery.includes(:observatory, :methodology, banner_attachment: :blob).all
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = Gallery.new(gallery_params)
    if @gallery.save
      SetTags.tagging(@gallery, params)
      redirect_to dashboard_galleries_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @album = Album.new
  end

  def update
    if @gallery.update(gallery_params)
      SetTags.tagging(@gallery, params)
      redirect_to dashboard_galleries_path
      if params[:gallery].keys.all? 'published'
        if @gallery.published
          flash[:notice] = 'Acervo publicado'
        else
          flash[:notice] = 'Acervo despublicado'
        end
      else
        flash[:notice] = 'Acervo atualizado'
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @gallery.destroy
    redirect_to dashboard_galleries_path, notice: 'Galeria destruída'
  end

  private

  def set_gallery
    if params[:id].match?(/[a-zA-Z]+/)
      @gallery = Gallery.find_by(name: params[:id])
    else
      @gallery = Gallery.find(params[:id])
    end
  end

  def gallery_params
    params.require(:gallery).permit(:name, :category, :published, :banner, :is_event, :event_date)
  end
end
