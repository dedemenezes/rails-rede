class AlbumsController < ApplicationController
  def show
    @album = Album.includes(photos_attachments: :blob).find_by(name: params[:name])
    @documents = @album.documents
    authorize @album
    add_breadcrumb_based_on_category
  end

  private

  def add_breadcrumb_based_on_category
    case @album.category
    when 'photo'
      add_breadcrumb 'Acervo (Imagens)', imagens_galleries_path
      add_breadcrumb "#{@album.gallery.name} (Imagens)", gallery_path(@album.gallery, t: 'imagens')
    else
      add_breadcrumb 'Acervo (Materiais)', materials_path
      add_breadcrumb "#{@album.gallery.name} (Materiais)", material_path(@album.gallery)
    end
    add_breadcrumb @album.name, album_path(@album), current: true
  end
end
