class DashboardController < ApplicationController
  before_action :add_default_dashboard_breadcrumb

  def home
    @project_count = Project.count
    @methodology_count = Methodology.count
    @user_count = User.count
    @tilesets = Tilesets::TilesetService.load_all
    authorize [:dashboard, current_user]
  end
end
