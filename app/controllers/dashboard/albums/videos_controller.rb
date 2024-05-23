module Dashboard

  class Albums::VideosController < DashboardController
    def index
      @albums = Album.with_videos
    end

    def new
      @album = Album.new
      @album.videos.build
    end

    def create
    end
  end
end
