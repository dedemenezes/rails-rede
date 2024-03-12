module Dashboard
  class ConflictTypesController < ApplicationController
    layout 'dashboard'
    before_action :set_dashboard_conflict_type, only: %i[show edit update destroy]

    def index
      @dashboard_conflict_types = ConflictType.all
    end

    def show
    end

    def new
      @dashboard_conflict_type = ConflictType.new
    end

    def edit
    end

    def create
      @dashboard_conflict_type = ConflictType.new(dashboard_conflict_type_params)

      if @dashboard_conflict_type.save
        redirect_to dashboard_conflict_types_path, notice: "Conflito criado."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @dashboard_conflict_type.update(dashboard_conflict_type_params)
        redirect_to dashboard_conflict_types_path, notice: "Conflict type was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @dashboard_conflict_type.destroy

      redirect_to dashboard_conflict_types_path, notice: "Conflict type was successfully destroyed."
    end

    private

    def set_dashboard_conflict_type
      @dashboard_conflict_type = ConflictType.find(params[:id])
    end

    def dashboard_conflict_type_params
      params.require(:conflict_type).permit(:name)
    end
  end
end
