class Navbar::ImagesController < ApplicationController
  def index
    binding.b
    @galleries = policy_scope(Album)
              .published_with_photos
              .limit(3)
              .map(&:gallery)
              .uniq
    # p @galleries
    # binding.break
    render partial: "shared/nav_images", locals: { nav_albums: @galleries }
  end
end
