class DashboardController < ApplicationController
  before_action :add_default_dashboard_breadcrumb

  def home
    @project_count = Project.count
    @methodology_count = Methodology.count
    @user_count = User.count
    @tilesets = Tileset.all.map do |tileset|
      {
        sourceValue: tileset.mapbox_id,
        urlValue: "mapbox://dedemenezes.#{tileset.mapbox_id}"
      }
    end
    authorize [:dashboard, current_user]
  end
end
