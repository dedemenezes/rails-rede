class Dashboard::ProjectsController < ApplicationController
  layout 'dashboard'

  def index
    @projects = policy_scope([:dashboard, Project])
    authorize [:dashboard, :projects, current_user]
  end

  def show
    @project = Project.find(params[:id])
    authorize [:dashboard, @project]
  end

  def new
    @project = Project.new
    authorize [:dashboard, @project]
  end

  def create
    @project = Project.new(project_params)
    authorize [:dashboard, @project]
    if @project.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :content, :banner)
  end
end
