class Dashboard::VideosController < DashboardController
  def index
    @videos = Video.all
  end

  def destroy
    @video = Video.find(params[:id])
    authorize @video
    @video.destroy
    redirect_to edit_dashboard_album_path(@video.album)
  end
end
