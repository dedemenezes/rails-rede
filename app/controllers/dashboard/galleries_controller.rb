class Dashboard::GalleriesController < ApplicationController
  layout 'dashboard'

  before_action :set_gallery, only: %i[edit update destroy]

  def index
    @galleries = Gallery.all
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = Gallery.new(gallery_params)
    set_observatory

    if @gallery.save
      redirect_to dashboard_galleries_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @album = Album.new
  end

  def update
    set_observatory

    if @gallery.update(gallery_params)
      redirect_to dashboard_galleries_path
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
    @gallery = Gallery.find(params[:id])
  end

  def gallery_params
    params.require(:gallery).permit(:name, :category, :published, :banner)
  end

  def set_observatory
    return if @gallery.observatory

    begin
      @observatory = Observatory.find(params[:gallery][:observatory_id])
    rescue => exception
      @observatory = nil
    end

    @gallery.observatory = @observatory
  end
end
