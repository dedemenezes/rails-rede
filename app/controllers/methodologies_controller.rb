class MethodologiesController < ApplicationController
  def show
    @methodology = Methodology.find(params[:id])
    authorize @methodology
  end
end
