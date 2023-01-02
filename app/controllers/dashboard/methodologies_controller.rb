class Dashboard::MethodologiesController < ApplicationController
  def new
    @methodology = Methodology.new
    @project = Project.find(params[:project_id])
    authorize @methodology
  end

  def create
    @project = Project.find(params[:project_id])
    @methodology = Methodology.create(methodology_params)
    @methodology.project = @project
    authorize @methodology
    if @methodology.save
      redirect_to dashboard_methodologies_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def methodology_params
    params.require(:methodology).permit(:name)
  end
end
