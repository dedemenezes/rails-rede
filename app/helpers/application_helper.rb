module ApplicationHelper

  def tab_active?(expected)
    params[:controller] == expected ? 'active' : ''
  end
end
