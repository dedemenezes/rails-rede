class AlbumsController < ApplicationController
  def show
    @album = Album.find(params[:id])
    authorize @album
  end
end
