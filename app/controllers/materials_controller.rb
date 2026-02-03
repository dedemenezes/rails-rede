class MaterialsController < ApplicationController
  def index
    document_galleries = policy_scope(Album)
                         .includes(:gallery)
                         .published_with_documents
                         .map(&:gallery)
                         .select(&:published)
                         .uniq
    video_galleries = policy_scope(Album)
                      .includes(:gallery)
                      .published_with_videos
                      .map(&:gallery)
                      .select(&:published)
                      .uniq
    @galleries = (document_galleries + video_galleries).uniq
  end

  def show
    @gallery = Gallery.includes(:banner_attachment).find_by_name(params[:name])
    @albums = @gallery.albums.includes(banner_attachment: :blob).materials
    authorize @gallery
    add_breadcrumb 'Acervo (Materiais)', materials_path, current: false
    add_breadcrumb "#{@gallery.name} (Materiais)", materials_path(@gallery), current: true
  end
end
