class MethodologiesController < ApplicationController
  def show
    @methodology = Methodology.with_attached_banner.with_attached_banner_two.find_by(name: params[:name])
    authorize @methodology
  end
end
