module Dashboard
  class ObservatoriesController < ApplicationController
    layout 'dashboard'

    before_action :set_observatory, only: %i[edit destroy update]

    def index
      @observatories = Observatory.all
    end

    def new
      @observatory = Observatory.new
    end

    def create
      @observatory = Observatory.new(observatory_params)
      if @observatory.save
        set_observatory_category
        set_observatory_conflict
        flash[:notice] = "#{@observatory.name} created successfully"
        redirect_to dashboard_observatories_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      if @observatory.destroy
        redirect_to dashboard_observatories_path
      else
        flash[:alert] = 'Observatorio não foi removido'
      end
    end

    def edit
    end

    def update
      @priority_type = PriorityType.find(params[:observatory][:priority_type]) if params[:observatory][:priority_type].present?
      @observatory.priority_type = @priority_type
      if @observatory.update!(observatory_params)
        redirect_to dashboard_observatories_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def set_observatory
      @observatory = Observatory.find(params[:id])
    end

    def observatory_params
      params.require(:observatory).permit(:name, :address, :email, :phone_number, :description, :unity_type_id,
                                          :rich_description, :banner, :latitude, :longitude, :street, :number,
                                          :city, :state, :zip_code, :neighborhood, :published)
    end

    def set_observatory_category
      category = Category.find(params[:observatory][:category])
      ObservatoryCategory.create(observatory: @observatory, category: category)
    end

    def set_observatory_conflict
      conflict_type = ConflictType.find(params[:observatory][:conflict_type])
      ObservatoryConflict.create(observatory: @observatory, conflict_type: conflict_type)
    end
  end
end
