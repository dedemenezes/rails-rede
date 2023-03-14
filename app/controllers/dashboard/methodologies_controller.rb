module Dashboard
  class MethodologiesController < ApplicationController
    layout 'dashboard'
    def new
      @methodology = Methodology.new
      authorize @methodology
    end

    def create
      @project = Project.first
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
      params.require(:methodology).permit(:name, :description, :banner, :header_one, :description_one, :header_two, :description_two, :banner_two, :content)
    end
  end
end
