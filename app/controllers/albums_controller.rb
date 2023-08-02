class AlbumsController < ApplicationController
  def show
    @album = Album.includes(photos_attachments: :blob).find_by(name: params[:name])
    @documents = @album.documents
    authorize @album

    gallery_breadcrumb_type_info = @album.documents.attached? ? '(Documentos)' : '(Imagens)'
    path_to_gallery = @album.documents.attached? ? documentos_gallery_path(@album.gallery) : imagens_gallery_path(@album.gallery)
    add_breadcrumb 'Acervo', galleries_path
    add_breadcrumb "#{@album.gallery.name} #{gallery_breadcrumb_type_info}", path_to_gallery
    add_breadcrumb @album.name, album_path(@album), current: true
  end
end
