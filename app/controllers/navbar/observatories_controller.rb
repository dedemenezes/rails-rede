class Navbar::ObservatoriesController < ApplicationController
  def index
    @nav_observatories = policy_scope(Observatory).pluck(:name, :id).sort_by { |name, _id| name }
    local_values = if params[:mobile]
      { nav_observatories: @nav_observatories, mobile: params[:mobile] }
    else
      { nav_observatories: @nav_observatories }
    end
    render partial: "shared/nav_observatories", locals: local_values
  end
end
