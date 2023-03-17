class GalleriesController < ApplicationController
  def index
    @galleries = policy_scope(Gallery)
    add_breadcrumb 'Acervo', galleries_path, current: true
  end

  def show
    @gallery = Gallery.includes(albums: { banner_attachment: :blob}).find_by(name: params[:name])
    authorize @gallery
    add_breadcrumb 'Acervo', galleries_path
    add_breadcrumb @gallery.name, gallery_path(@gallery), current: true
  end
end
