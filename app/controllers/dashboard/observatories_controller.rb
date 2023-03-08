module Dashboard
  class ObservatoriesController < ApplicationController
    layout 'dashboard'

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
      @observatory = Observatory.find(params[:id])
      if @observatory.destroy
        redirect_to dashboard_observatories_path
      else
        render :index, status: :unprocessable_entity
      end
    end

    def edit
      @observatory = Observatory.find(params[:id])
    end

    private

    def observatory_params
      params.require(:observatory).permit(:name, :address, :email, :phone_number, :description, :unity_type_id,
                                          :rich_description, :banner, :latitude, :longitude)
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
