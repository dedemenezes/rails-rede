class DashboardController < ApplicationController

  def home
    @project_count = Project.count
    @methodology_count = Methodology.count
    @user_count = User.count
    authorize [:dashboard, current_user]
  end
end
