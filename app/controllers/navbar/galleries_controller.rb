class Navbar::GalleriesController < ApplicationController
  def show
    puts "##########PARAMS########"
    p params
    @gallery = Gallery.find_by(name: params[:name])
    @albums = @gallery.albums.published_with_photos[..1]
    render partial: "shared/nav_gallery_show", locals: { albums: @albums, gallery: @gallery }
    authorize @gallery
  end
end
