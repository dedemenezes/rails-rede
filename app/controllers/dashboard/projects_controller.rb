class Dashboard::ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update]

  layout 'dashboard'

  def index
    @projects = policy_scope([:dashboard, Project])
    authorize [:dashboard, :projects, current_user]
  end

  def show
  end

  def new
    @project = Project.new
    authorize [:dashboard, @project]
  end

  def create
    @project = Project.new(project_params)
    authorize [:dashboard, @project]
    if @project.save
      redirect_to dashboard_projects_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @image_attachments =  ActiveStorage::Attachment.where(record_id: Project.last.id, record_type: 'ActiveStorage::VariantRecord')
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
    @project = Project.find(params[:id])
    authorize [:dashboard, @project]
  end

  def project_params
    params.require(:project).permit(:name, :content, :banner)
  end
end
