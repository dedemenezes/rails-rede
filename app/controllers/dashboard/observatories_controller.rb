class Dashboard::ObservatoriesController < ApplicationController
  layout 'dashboard'

  def index
    @observartories = Observatory.all
  end
end
