class Navbar::PesquisasController < ApplicationController
  def index
    @galleries = policy_scope(Gallery).joins(albums: :documents_attachments)
                                      .where.not(methodology_id: nil)
                                      .where(name: "Formação e Pesquisa", albums: { published: true, category: 'document' })
                                      .distinct
                                      .order(name: :asc)

    render partial: "shared/nav_pesquisa", locals: { nav_galleries: @galleries }
  end
end
