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
end
