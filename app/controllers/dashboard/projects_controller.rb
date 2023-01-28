module Dashboard
  class ProjectsController < ApplicationController
    before_action :set_project, only: %i[show edit update]
    before_action :set_breadcrumb_index, except: %i[index]

    layout 'dashboard'

    def index
      @projects = Project.all
      add_breadcrumb 'Projects', dashboard_projects_path, true
    end

    def show
      add_breadcrumb @project.name, nil, true
    end

    def new
      @project = Project.new
      add_breadcrumb 'New project', new_dashboard_project_path, true
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
      add_breadcrumb @project.name, dashboard_project_path(@project), false
      add_breadcrumb "Edit", nil, true
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
    end

    def project_params
      params.require(:project).permit(:name, :content, :banner)
    end

    def set_breadcrumb_index
      add_breadcrumb 'Projects', dashboard_projects_path, false
    end
  end
end
