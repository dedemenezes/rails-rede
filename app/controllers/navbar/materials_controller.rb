module Navbar
  class MaterialsController < ApplicationController
    def index
      @galleries = policy_scope(Gallery).joins(albums: :documents_attachments)
                                        .where.not(methodology_id: nil)
                                        .where(albums: { published: true, category: 'document' })
                                        .distinct
                                        .order(name: :asc)
      if params[:q].present?
        render partial: "shared/navbar/photo_galleries",
               locals: { nav_galleries: @galleries, target_id: :nav_materials_galleries,
                         url: :material_path }
      else
        render partial: "shared/nav_materials", locals: { nav_galleries: @galleries }
      end
    end
  end
end
