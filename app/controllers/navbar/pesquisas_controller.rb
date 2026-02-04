module Navbar
  class PesquisasController < ApplicationController
    def index
      @galleries = policy_scope(Gallery).joins(albums: :documents_attachments)
                                        .where.not(methodology_id: nil)
                                        .where(name: "Formação e Pesquisa", albums: { published: true,
                                                                                      category: 'document' })
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
