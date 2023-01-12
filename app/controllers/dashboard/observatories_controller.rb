class Dashboard::ObservatoriesController < ApplicationController
  layout 'dashboard'

  def index
    @observartories = Observatory.all
  end

  def new
    @observatory = Observatory.new
  end
end
