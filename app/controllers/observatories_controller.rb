class ObservatoriesController < ApplicationController
  def index
    @observatories = policy_scope(Observatory).includes(:banner_attachment)
    @markers = @observatories.geocoded.map do |observatory|
      {
        lat: observatory.latitude,
        lng: observatory.longitude
      }
    end
  end

  def show
    @observatory = Observatory.find(params[:id])
    authorize @observatory
  end

  def mapa
    @observatories = policy_scope(Observatory)
    @markers = @observatories.geocoded.map do |observatory|
      {
        lat: observatory.latitude,
        lng: observatory.longitude,
        info_window: render_to_string(partial: 'info_window', locals: { observatory: observatory }),
        image_url: helpers.asset_path('icon-pin--blue.svg')
      }
    end
  end
end
