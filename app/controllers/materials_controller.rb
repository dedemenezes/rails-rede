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
end
