class Dashboard::VideosController < DashboardController
  before_action :set_video, only: %i[show edit destroy update]

  def index
    @videos = Video.all.order(updated_at: :desc)
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      redirect_to dashboard_videos_path, notice: "Vídeo criado."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @video.update(video_params)
      redirect_to dashboard_videos_path, notice: "Vídeo atualizado."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @video.destroy
      redirect_to dashboard_videos_path, notice: 'Vídeo removido.'
    else
      @videos = Video.all.order(updated_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_video
    @video = Video.find(params[:id])
    authorize @video
  end

  def video_params
    params.require(:video).permit(:name, :url)
  end
end
