class Dashboard::GalleriesController < ApplicationController
  layout 'dashboard'

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = Gallery.new(gallery_params)
    @observatory = Observatory.find(params[:gallery][:observatory])
    @gallery.observatory = @observatory
    if @gallery.save
      redirect_to dashboard_galleries_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def gallery_params
    params.require(:gallery).permit(:name, :category)
  end
end
