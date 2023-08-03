class GalleriesController < ApplicationController
  def index
    @galleries = policy_scope(Gallery).includes(:albums).order(name: :asc)
    add_breadcrumb 'Acervo', galleries_path, current: true
  end

  def show
    @gallery = Gallery.includes(albums: { banner_attachment: :blob}).find_by(name: params[:name]) || Gallery.find(params[:id])
    @albums = @gallery.published_albums.sort_by(&:updated_at).reverse
    if params[:t].present?
      if params[:t] == 'documentos'
        @albums = @albums.select { _1.documents.attached? }
        add_breadcrumb 'Acervo (Documentos)', documentos_galleries_path
      end
    end
    @albums = @albums.reject { _1.documents.attached? } if params[:t].present? && params[:t] == 'imagens'
    authorize @gallery
    add_breadcrumb "#{@gallery.name} (Documentos)", gallery_path(@gallery), current: true
  end

  def documentos
    @galleries = policy_scope(Gallery).includes(albums: [:documents_attachments]).order(name: :asc)
    @galleries = @galleries.select { |gallery| gallery.albums.any? { _1.documents.attached? } }
    add_breadcrumb 'Acervo', galleries_path, current: true
  end
end
