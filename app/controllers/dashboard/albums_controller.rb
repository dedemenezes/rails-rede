class Dashboard::AlbumsController < ApplicationController
  layout 'dashboard'

  def index
    @albums = Album.all
  end

  def new
    @album = Album.new
  end
end
