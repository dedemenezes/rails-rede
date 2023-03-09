class Articles::Index::TagsController < ApplicationController
  skip_after_action :verify_authorized
  def destroy
    updated_params = params[:tags].reject { |ts| ts == params[:name]}
    if params[:tags].size == 2
      redirect_to articles_path
    else
      redirect_to articles_path(tags: updated_params)
    end
  end
end
