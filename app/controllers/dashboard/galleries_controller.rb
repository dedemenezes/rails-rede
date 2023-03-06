class Dashboard::GalleriesController < ApplicationController
  layout 'dashboard'

  def index
    @galleries = Gallery.all
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = Gallery.new(gallery_params)
    begin
      @observatory = Observatory.find(params[:gallery][:observatory])
      @gallery.observatory = @observatory if @observatory
    rescue => exception
      @gallery.observatory = nil
    end

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
