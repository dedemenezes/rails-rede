class GalleriesController < ApplicationController
  def index
    @galleries = policy_scope(Gallery)
    add_breadcrumb 'Galleries', galleries_path, current: true
  end

  def show
    @gallery = Gallery.find(params[:id])
    authorize @gallery
    add_breadcrumb 'Galleries', galleries_path
    add_breadcrumb @gallery.name, gallery_path(@gallery), current: true
  end
end
