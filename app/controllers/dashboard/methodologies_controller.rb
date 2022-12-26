class Dashboard::MethodologiesController < ApplicationController
  def new
    @methodology = Methodology.new
    @project = Project.find(params[:project_id])
  end
end
