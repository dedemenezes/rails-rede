class DashboardController < ApplicationController
  before_action :add_default_dashboard_breadcrumb

  def home
    @project_count = Project.count
    @methodology_count = Methodology.count
    @user_count = User.count
    @tilesets = Tileset.all.map do |tileset|
      geo_json = JSON.parse(tileset.geo_json)
      features = geo_json['features']
      points = features.select { |f| f['geometry']['type'] == 'Point' }
      icons = points.uniq { |f| f['properties']['icon'] }
                    .map { |f| f['properties']['icon'] }
      {
        sourceValue: tileset.mapbox_id,
        urlValue: "mapbox://dedemenezes.#{tileset.mapbox_id}",
        geoJson: tileset.geo_json,
        icons:
      }
    end
    authorize [:dashboard, current_user]
  end
end
