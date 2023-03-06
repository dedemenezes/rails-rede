module ApplicationHelper

  def tab_active?(expected)
    params[:controller] == expected ? 'active' : ''
  end

  def display_banner_as_background(article)
    if article.banner.attached?
      cl_image_path(article.banner.key)
    else
      image_path('default-banner.png')
    end
  end
  def display_banner(article, options = {})
    if article.banner.attached?
      cl_image_tag(article.banner.key, options)
    else
      image_tag('default-banner.png', options)
    end
  end

  def route_for_edit_dashboard(element)
    "#{element.class.to_s.humanize.downcase.pluralize}/#{element.id}/edit"
  end

  def hide_nested_links(name_of_controller)
    name_of_controller == 'albums'
  end
end
