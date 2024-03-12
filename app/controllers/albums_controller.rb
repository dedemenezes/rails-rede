class AlbumsController < ApplicationController
  def show
    @album = Album.includes(photos_attachments: :blob).find_by(name: params[:name])
    @documents = @album.documents
    authorize @album
    if @album.documents.attached?
      add_breadcrumb 'Acervo (Documentos)', documentos_galleries_path
      add_breadcrumb "#{@album.gallery.name} (Documentos)", gallery_path(@album.gallery, t: 'documentos')
      add_breadcrumb @album.name, album_path(@album), current: true
    end

    return if @album.documents.attached?

    add_breadcrumb 'Acervo (Imagens)', imagens_galleries_path
    add_breadcrumb "#{@album.gallery.name} (Imagens)", gallery_path(@album.gallery, t: 'imagens')
    add_breadcrumb @album.name, album_path(@album), current: true
  end
end
