class Navbar::ImagesController < ApplicationController
  def index
    @galleries = policy_scope(Album)
              .published_with_photos
              .map(&:gallery)
              .uniq
    if params[:q].present?
      if params[:q] == "offcanvas"
        render partial: "shared/navbar/photo_galleries", locals: { nav_galleries: @galleries, target_id: :nav_photo_galleries, url: :gallery_path }
      end
    else
      render partial: "shared/nav_images", locals: { nav_galleries: @galleries }
    end
  end
end
