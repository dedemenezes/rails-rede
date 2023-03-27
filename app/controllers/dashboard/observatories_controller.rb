module Dashboard
  class ObservatoriesController < ApplicationController
    layout 'dashboard'

    before_action :set_observatory, only: %i[edit destroy update]

    def index
      @observatories = Observatory.includes(banner_attachment: :blob).all
    end

    def new
      @observatory = Observatory.new
    end

    def create
      @observatory = Observatory.new(observatory_params)
      if @observatory.save
        set_observatory_priority_subjects
        set_observatory_conflict
        flash[:notice] = "#{@observatory.name} criado"
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
      if @observatory.update(observatory_params)
        set_observatory_priority_subjects
        set_observatory_conflict
        redirect_to dashboard_observatories_path
        flash[:notice] = "#{@observatory.name} atualizado"
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def set_observatory
      if params[:id].match?(/[a-zA-Z]+/)
        @observatory = Observatory.find_by(name: params[:id])
      else
        @observatory = Observatory.find(params[:id])
      end
    end

    def observatory_params
      params.require(:observatory).permit(:name, :address, :email, :phone_number, :description, :unity_type_id,
                                          :rich_description, :banner, :latitude, :longitude, :street, :number,
                                          :city, :state, :zip_code, :neighborhood, :municipality, :published, :priority_type_id, :conflict_type_ids)
    end

    def set_observatory_conflict
      @observatory.conflict_types.destroy_all
      conflict_type = ConflictType.where(id: params[:observatory][:conflict_type_ids]).first
      ObservatoryConflict.create(observatory: @observatory, conflict_type: conflict_type)

    end

    def set_observatory_priority_subjects
      @observatory.priority_subjects.destroy_all
      subject_ids =  params[:observatory][:priority_subject_ids]
      return if subject_ids == [""]

      priority_subjects = PriorityType.where(id: params[:observatory][:priority_subject_ids])
      priority_subjects.each do |ps|
        ObservatoryPrioritySubject.create priority_type: ps, observatory: @observatory
      end
    end
  end
end
