class AlbumsController < ApplicationController
  def show
    @album = Album.includes(photos_attachments: :blob).find_by(name: params[:name])
    authorize @album
    add_breadcrumb 'Acervo', galleries_path
    add_breadcrumb @album.gallery.name, gallery_path(@album.gallery)
    add_breadcrumb @album.name, album_path(@album), current: true
  end
end
