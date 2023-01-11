class Dashboard::CategoriesController < ApplicationController
  layout 'dashboard'

  def index
    @categories = policy_scope([:dashboard, Category])
    add_breadcrumb 'Categories', dashboard_categories_path
  end

  def new
    @category = Category.new
    authorize [:dashboard, @category]
    add_breadcrumb 'Categories', dashboard_categories_path
    add_breadcrumb 'New category', new_dashboard_category_path, true
  end

  def create
    @category = Category.new(category_params)
    authorize [:dashboard, @category]
    if @category.save
      redirect_to dashboard_path, notice: 'Category created successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
