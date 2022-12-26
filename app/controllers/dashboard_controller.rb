class DashboardController < ApplicationController

  def home
    authorize [:dashboard, current_user]
  end
end
