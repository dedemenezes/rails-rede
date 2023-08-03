class GalleriesController < ApplicationController
  def index
    @galleries = policy_scope(Gallery).includes(albums: [:photos_attachments, :documents_attachments]).order(name: :asc)
    add_breadcrumb 'Acervo', galleries_path, current: true
  end

  def show
    @gallery = Gallery.includes(albums: [:documents_attachments, { banner_attachment: :blob}]).find_by(name: params[:name]) || Gallery.find(params[:id])
    @albums = @gallery.published_albums.sort_by(&:updated_at).reverse
    if params[:t].present?
      if params[:t] == 'documentos'
        @albums = @albums.select { _1.documents.attached? }
        add_breadcrumb 'Acervo (Documentos)', documentos_galleries_path
        add_breadcrumb "#{@gallery.name} (Documentos)", gallery_path(@gallery), current: true
      end
      if params[:t] == 'imagens'
        @albums = @albums.reject { _1.documents.attached? }
        add_breadcrumb 'Acervo (Imagens)', imagens_galleries_path
        add_breadcrumb "#{@gallery.name} (Imagens)", gallery_path(@gallery), current: true
      end
    end
    authorize @gallery
  end

  def documentos
    @galleries = policy_scope(Gallery).includes(albums: [:documents_attachments]).order(name: :asc)
    @galleries = @galleries.select { |gallery| gallery.albums.any? { _1.documents.attached? } }
    add_breadcrumb 'Acervo', galleries_path, current: true
  end

  def imagens
    @galleries = policy_scope(Gallery).includes(albums: [:documents_attachments]).order(name: :asc)
    @galleries = @galleries.reject { |gallery| gallery.albums.all? { _1.documents.attached? } }
    add_breadcrumb 'Acervo', galleries_path, current: true
  end
end
