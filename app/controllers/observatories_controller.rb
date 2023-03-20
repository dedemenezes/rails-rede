class ObservatoriesController < ApplicationController
  def index
    @observatories = policy_scope(Observatory)
    @markers = @observatories.map do |observatory|
      {
        lat: observatory.latitude,
        lng: observatory.longitude
      }
    end
  end

  def show
    @observatory = Observatory.includes(:priority_subjects, :conflict_type, :gallery, :articles, :albums, banner_attachment: :blob, albums: { banner_attachment: :blob }).find_by(name: params[:name]) || Observatory.find(params[:id])
    @albums = @observatory.albums
    authorize @observatory
  end

  def mapa
    @observatories = policy_scope(Observatory).where.not(latitude: nil, longitude: nil)
    @markers = @observatories.map do |observatory|
      {
        lat: observatory.latitude,
        lng: observatory.longitude,
        info_window: render_to_string(partial: 'info_window', locals: { observatory: observatory }),
        image_url: helpers.asset_path('icon-pin--blue.svg')
      }
    end
  end
end
