module Dashboard
  class MethodologiesController < ApplicationController
    layout 'dashboard'

    before_action :set_methodology, only: %i[edit update destroy]
    def index
      @methodologies = Methodology.all
    end

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

    def edit
    end

    def update
      if @methodology.update(methodology_params)
        redirect_to dashboard_methodologies_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @methodology.destroy
      redirect_to dashboard_methodologies_path
      flash[:notice] = 'Metodologia destruída'
    end

    private

    def set_methodology
      if params[:id].match?(/[a-zA-Z]+/)
        @methodology = Methodology.find_by(name: params[:id])
      else
        @methodology = Methodology.find(params[:id])
      end
    end

    def methodology_params
      params.require(:methodology).permit(:name, :description, :banner, :header_one, :description_one, :header_two, :description_two, :banner_two, :content)
    end
  end
end
