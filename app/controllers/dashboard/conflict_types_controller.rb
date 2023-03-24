class Dashboard::ConflictTypesController < ApplicationController
  layout 'dashboard'
  before_action :set_dashboard_conflict_type, only: %i[ show edit update destroy ]

  # GET /dashboard/conflict_types or /dashboard/conflict_types.json
  def index
    @dashboard_conflict_types = ConflictType.all
  end

  # GET /dashboard/conflict_types/1 or /dashboard/conflict_types/1.json
  def show
  end

  # GET /dashboard/conflict_types/new
  def new
    @dashboard_conflict_type = ConflictType.new
  end

  # GET /dashboard/conflict_types/1/edit
  def edit
  end

  # POST /dashboard/conflict_types or /dashboard/conflict_types.json
  def create
    @dashboard_conflict_type = ConflictType.new(dashboard_conflict_type_params)

    respond_to do |format|
      if @dashboard_conflict_type.save
        format.html { redirect_to dashboard_conflict_types_path, notice: "Conflito criado." }
        format.json { render :show, status: :created, location: @dashboard_conflict_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dashboard_conflict_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboard/conflict_types/1 or /dashboard/conflict_types/1.json
  def update
    respond_to do |format|
      if @dashboard_conflict_type.update(dashboard_conflict_type_params)
        format.html { redirect_to dashboard_conflict_types_path, notice: "Conflict type was successfully updated." }
        format.json { render :show, status: :ok, location: @dashboard_conflict_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dashboard_conflict_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboard/conflict_types/1 or /dashboard/conflict_types/1.json
  def destroy
    @dashboard_conflict_type.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_conflict_types_url, notice: "Conflict type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_dashboard_conflict_type
    @dashboard_conflict_type = ConflictType.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def dashboard_conflict_type_params
    params.require(:conflict_type).permit(:name)
  end
end
