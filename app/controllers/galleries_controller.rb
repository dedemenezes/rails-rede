class GalleriesController < ApplicationController
  def index
    @galleries = policy_scope(Gallery)
  end

  def show
    @gallery = Gallery.find(params[:id])
    authorize @gallery
  end
end
