class ObservatoriesController < ApplicationController
  def index
    @observatories = policy_scope(Observatory)
    @markers = @observatories.geocoded.map do |observatory|
      {
        lat: observatory.latitude,
        lng: observatory.longitude
      }
    end
  end
end
