class Dashboard::AlbumsController < ApplicationController
  layout 'dashboard'

  before_action :set_album, only: %i[edit update update_banner destroy]

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
      redirect_to edit_dashboard_album_path(@album), notice: 'Novo albúm criado'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @album.update(album_params) && @album.banner.attached?
      redirect_to edit_dashboard_album_path(@album), notice: 'Album atualizado'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_banner
    @photo = @album.photos.find{ _1.id == params[:photo_id].to_i }
    @album.set_banner(@photo)
    if @album.save
      redirect_to dashboard_albums_path, notice: 'Banner atualizado'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @album.destroy
    redirect_to dashboard_albums_path, notice: 'Album destruído'
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:name, photos: [])
  end
end
