module ApplicationHelper

  def tab_active?(expected, options = {})
    # raise
    condition = params[:controller] == expected
    if params[:controller] == 'pages' || params[:controller] == 'observatories'
      condition = params[:action] == options[:action] && params[:controller] == expected
    end
    condition ? 'active' : ''
  end

  def display_banner_as_background(element)
    if element.banner.attached?
      cl_image_path(element.banner.key)
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
