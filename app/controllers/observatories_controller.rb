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
  end
end
