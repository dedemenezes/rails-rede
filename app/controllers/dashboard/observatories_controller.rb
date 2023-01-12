class Dashboard::ObservatoriesController < ApplicationController
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
      category = Category.find(params[:observatory][:category])
      priority_type = PriorityType.find(params[:observatory][:priority_type])
      conflict_type = ConflictType.find(params[:observatory][:conflict_type])
      ObservatoryCategory.create(observatory: @observatory, category: category)
      ObservatoryPriority.create(observatory: @observatory, priority_type: priority_type)
      ObservatoryConflict.create(observatory: @observatory, conflict_type: conflict_type)
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
  private

  def observatory_params
    params.require(:observatory).permit(:name, :address, :email, :phone_number, :description, :unity_type_id, :rich_description, :banner)
  end
end
