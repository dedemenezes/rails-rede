class MethodologiesController < ApplicationController
  def show
    @methodology = Methodology.with_attached_banner.with_attached_banner_two.find(params[:id])
    authorize @methodology
  end
end
