class Navbar::ImagesController < ApplicationController
  def index
    @galleries = policy_scope(Album)
              .published_with_photos
              .limit(3)
              .map(&:gallery)
              .uniq
    render partial: "shared/nav_images", locals: { nav_albums: @galleries }
  end
end
