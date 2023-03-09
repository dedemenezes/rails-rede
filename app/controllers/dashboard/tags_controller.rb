class Dashboard::TagsController < ApplicationController
  layout 'dashboard'

  def index
    @tags = Tag.all
  end
end
