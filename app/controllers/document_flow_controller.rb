class DocumentFlowController < ApplicationController
  def index
    # @galleries = policy_scope(Gallery).published_with_documents
    @galleries = policy_scope(Album).includes(:gallery).published_with_documents.map(&:gallery).uniq
  end

  def show
    @gallery = Gallery.find_by_name params[:name]
    @albums = Album.where(gallery: @gallery).published_with_documents
    authorize @gallery
  end
end
