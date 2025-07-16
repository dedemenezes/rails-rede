class Navbar::GalleriesController < ApplicationController
  def show
    @gallery = Gallery.find_by(name: params[:name])
    if params[:query].present?
      case params[:query]
      when 'materials'
        @albums = @gallery.albums.published_with_documents[..1]
        render partial: "shared/nav_gallery_materials", locals: { albums: @albums, gallery: @gallery }
      when 'photos'
        @albums = @gallery.albums.published_with_photos[..1]
        render partial: "shared/nav_gallery_photos", locals: { albums: @albums, gallery: @gallery }
      end
    end
    authorize @gallery
  end
end
