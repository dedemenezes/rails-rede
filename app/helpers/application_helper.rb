module ApplicationHelper

  def tab_active?(expected)
    params[:controller] == expected ? 'active' : ''
  end

  def display_banner(article)
    if article.banner.attached?
      cl_image_path(article.banner.key)
    else
      image_path('default-banner.png')
    end
  end

  def route_for_edit_dashboard(element)
    "#{element.class.to_s.humanize.downcase.pluralize}/#{element.id}/edit"
  end
end
