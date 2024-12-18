class Dashboard::Albums::MaterialsController < DashboardController
  skip_before_action :add_default_dashboard_breadcrumb
  def index
    # get all albums with videos and documents
    documents = Album.includes(:gallery, banner_attachment: :blob).with_documents
    images = Album.includes(:gallery, banner_attachment: :blob).with_videos
    @albums = documents + images
  end

  def new
    @album = Album.new
    @album.videos.build
  end
end
