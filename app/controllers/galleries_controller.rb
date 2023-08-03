class GalleriesController < ApplicationController
  def index
    @galleries = policy_scope(Gallery).includes(:albums).order(name: :asc)
    add_breadcrumb 'Acervo', galleries_path, current: true
  end

  def show
    @gallery = Gallery.includes(albums: { banner_attachment: :blob}).find_by(name: params[:name]) || Gallery.find(params[:id])
    @albums = @gallery.published_albums.sort_by(&:updated_at).reverse
    authorize @gallery
    add_breadcrumb 'Acervo', galleries_path
    add_breadcrumb @gallery.name, gallery_path(@gallery), current: true
  end

  def documentos
    @galleries = policy_scope(Gallery).includes(albums: [:documents_attachments]).order(name: :asc)
    @galleries = @galleries.select { |gallery| gallery.albums.any? { _1.documents.attached? } }
    add_breadcrumb 'Acervo', galleries_path, current: true
  end
end
