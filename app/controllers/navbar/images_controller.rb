class Navbar::ImagesController < ApplicationController
  def index
    @galleries = policy_scope(Album)
              .published_with_photos
              .map(&:gallery)
              .uniq
    render partial: "shared/nav_images", locals: { nav_galleries: @galleries }
  end
end
