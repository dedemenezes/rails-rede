class Dashboard::AlbumsController < ApplicationController
  layout 'dashboard'

  def index
    @albums = Album.joins(:gallery).all
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    begin
      @gallery = Gallery.find(params[:album][:gallery_id])
      @album.gallery = @gallery
    rescue => exception

    end
    if @album.save
      redirect_to dashboard_albums_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to dashboard_edit_album_path(@album)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def album_params
    params.require(:album).permit(:name, photos: [])
  end
end
