module Navbar
  class PesquisasController < ApplicationController
    def index
      @galleries = policy_scope(Gallery).where.not(methodology_id: nil)
                                        .with_published_albums
                                        .merge(Album.with_documents)
                                        .distinct
                                        .order(name: :asc)
      if params[:q].present?
        render partial: "shared/navbar/photo_galleries",
               locals: { nav_galleries: @galleries, target_id: :nav_pesquisa_galleries,
                         url: :material_path }
      else
        render partial: "shared/nav_pesquisa", locals: { nav_galleries: @galleries }
      end
    end
  end
end
