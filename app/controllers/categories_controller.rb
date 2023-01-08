class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @category_observatories = @category.observatories
    authorize @category
  end
end
