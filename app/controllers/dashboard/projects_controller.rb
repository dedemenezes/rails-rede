module Dashboard
  class ProjectsController < ApplicationController
    before_action :set_project, only: %i[show edit update]

    layout 'dashboard'

    def index
      @projects = Project.all
    end

    def show
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(project_params)
      if @project.save
        redirect_to dashboard_projects_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @methodology = Methodology.new
      @image_attachments = ActiveStorage::Attachment.where(record_id: Project.last.id,
                                                           record_type: 'ActiveStorage::VariantRecord')
    end

    def update
      if @project.update(project_params)
        redirect_to dashboard_projects_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_project
      if params[:id].match?(/[a-zA-Z]+/)
        @project = Project.find_by(name: params[:id])
      else
        @project = Project.find(params[:id])
      end
    end

    def project_params
      params.require(:project).permit(:name, :content, :banner, :banner_text, :slide_one, :slide_two, :slide_three,
                                      :slide_one_subtitle, :slide_two_subtitle, :slide_three_subtitle, :video_id,
                                      :yt_url, :ig_url, :fb_url, :email)
    end
  end
end
