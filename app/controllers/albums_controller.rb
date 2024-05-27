class AlbumsController < ApplicationController
  def show
    @album = Album.includes(photos_attachments: :blob).find_by(name: params[:name])
    @documents = @album.documents
    authorize @album
    case @album.category
    when 'document'
      add_breadcrumb 'Acervo (Documentos)', documentos_galleries_path
      add_breadcrumb "#{@album.gallery.name} (Documentos)", gallery_path(@album.gallery, t: 'documentos')
      add_breadcrumb @album.name, album_path(@album), current: true
    when 'photo'
      add_breadcrumb 'Acervo (Imagens)', imagens_galleries_path
      add_breadcrumb "#{@album.gallery.name} (Imagens)", gallery_path(@album.gallery, t: 'imagens')
      add_breadcrumb @album.name, album_path(@album), current: true
    when 'video'
      add_breadcrumb 'Acervo (Videos)', videos_galleries_path
      add_breadcrumb "#{@album.gallery.name} (Videos)", gallery_path(@album.gallery, t: 'videos')
      add_breadcrumb @album.name, album_path(@album), current: true
    end
  end
end
