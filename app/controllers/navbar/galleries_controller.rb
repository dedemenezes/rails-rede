class Navbar::GalleriesController < ApplicationController
  def show
    puts "##########PARAMS########"
    p params
    @gallery = Gallery.find_by(name: params[:name])
    render partial: "shared/nav_gallery_show", locals: { gallery: @gallery }
    authorize @gallery
  end
end
