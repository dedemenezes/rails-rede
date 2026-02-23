class Navbar::MethodologiesController < ApplicationController
  def index
    @methodologies = policy_scope(Methodology)
    render partial: 'shared/navbar/methodologies/index', locals: { methodologies: @methodologies }
  end
end
