class GalleriesController < ApplicationController
  def index
    @galleries = policy_scope(Gallery)
  end

  def show
  end
end
