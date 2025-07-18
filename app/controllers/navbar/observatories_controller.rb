class Navbar::ObservatoriesController < ApplicationController
  def index
    @nav_observatories = policy_scope(Observatory).pluck(:name, :id)
    render partial: "shared/nav_observatories", locals: { nav_observatories: @nav_observatories }
  end
end
