class PagesController < ApplicationController

  def home
    @observatories = policy_scope(Observatory)
    @markers = @observatories.geocoded.map do |observatory|
      {
        lat: observatory.latitude,
        lng: observatory.longitude,
        info_window: render_to_string(partial: 'observatories/info_window', locals: { observatory: observatory }),
        image_url: helpers.asset_path('icon-pin--blue.svg')
      }
    end
  end

  def contact
  end

  def about_us
    @methodologies = Methodology.all
  end
end
