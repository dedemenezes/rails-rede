class Navbar::MaterialsController < ApplicationController
  def index
    @galleries = policy_scope(Album)
              .published_with_documents
              .map(&:gallery)
              .uniq
    if params[:q].present?
      render partial: "shared/navbar/photo_galleries", locals: { nav_galleries: @galleries, target_id: :nav_materials_galleries, url: :material_path }
    else
      render partial: "shared/nav_materials", locals: { nav_galleries: @galleries }
    end
  end
end
