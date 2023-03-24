class Dashboard::PriorityTypesController < ApplicationController
  layout 'dashboard'
  before_action :set_priority_subject, only: %i[edit update destroy]

  def index
    @priority_subjects = PriorityType.all
  end

  def new
    @priority_subject = PriorityType.new
  end

  def create
    @priority_subject = PriorityType.new(priority_subject_params)
    if @priority_subject.save
      redirect_to dashboard_priority_types_path, notice: 'Sujeito prioritário criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @priority_subject.update(priority_subject_params)
    if @priority_subject.save
      redirect_to dashboard_priority_types_path, notice: 'Sujeito prioritário criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @priority_subject.destroy
      flash[:notice] = 'Sujeito prioritário removido'
    else
      flash[:alert] = 'Ocorreu algum problema...'
    end

    redirect_to dashboard_priority_types_path
  end

  private

  def set_priority_subject
    @priority_subject = PriorityType.find(params[:id])
  end

  def priority_subject_params
    params.require(:priority_type).permit(:name)
  end
end
