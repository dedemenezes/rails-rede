class Navbar::MaterialsController < ApplicationController
  def index
    @galleries = policy_scope(Album)
              .published_with_documents
              .map(&:gallery)
              .uniq
    render partial: "shared/nav_materials", locals: { nav_galleries: @galleries }
  end
end
