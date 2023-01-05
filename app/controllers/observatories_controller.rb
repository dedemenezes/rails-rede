class ObservatoriesController < ApplicationController
  def index
    @observatories = policy_scope(Observatory)
  end
end
