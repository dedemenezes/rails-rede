module Dashboard
  class CollaboratorsController < DashboardController
    before_action :set_collaborator, only: %i[edit update destroy]
    def index
      @collaborators = policy_scope(Collaborator)
    end

    def new
      @collaborator = Collaborator.new
    end

    def create
      # binding.break
      @collaborator = Collaborator.new(params_collaborator)
      if @collaborator.save
        redirect_to dashboard_collaborators_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @collaborator.update(params_collaborator)
        redirect_to dashboard_collaborators_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @collaborator.destroy
      redirect_to dashboard_collaborators_path
      flash[:notice] = 'Colaborador removido com sucesso'
    end

    private

    def set_collaborator
      @collaborator = Collaborator.find(params[:id])
    end

    def params_collaborator
      params.require(:collaborator).permit(:name, :occupation, :location, :testimonial, :avatar)
    end
  end
end
