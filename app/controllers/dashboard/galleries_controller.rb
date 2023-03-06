class Dashboard::GalleriesController < ApplicationController
  layout 'dashboard'

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
    @gallery = Gallery.find(params[:id])
    @album = Album.new
  end

  def update
    @gallery = Gallery.find(params[:id])
    set_observatory

    if @gallery.update(gallery_params)
      redirect_to dashboard_galleries_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def gallery_params
    params.require(:gallery).permit(:name, :category, :published, :banner)
  end

  def set_observatory
    begin
      @observatory = Observatory.find(params[:gallery][:observatory_id])
    rescue => exception
      @observatory = nil
    end

    @gallery.observatory = @observatory
  end
end
