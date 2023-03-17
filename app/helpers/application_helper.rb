module ApplicationHelper

  def tab_active?(expected, options = {})
    # raise
    condition = params[:controller] == expected
    if params[:controller] == 'pages' || params[:controller] == 'observatories' || params[:controller] == 'contacts'
      condition = params[:action] == options[:action] && params[:controller] == expected
    end
    condition ? 'active' : ''
  end

  def display_banner_as_background(instance)
    if instance.banner.attached?
      "https://rails-rede-demo-dev-2.s3.us-east-2.amazonaws.com/#{instance.banner.key}"
    else
      image_path('default-banner.png')
    end
  end

  def display_banner(instance, options = {})
    if instance.banner.attached?
      url = "https://rails-rede-demo-dev-2.s3.us-east-2.amazonaws.com/#{instance.banner.key}"
    else
      url = 'default-banner.png'
    end
    image_tag(url, options)
  end

  def route_for_edit_dashboard(element)
    "#{element.class.to_s.humanize.downcase.pluralize}/#{element.id}/edit"
  end

  def hide_nested_links(name_of_controller)
    name_of_controller == 'albums'
  end

  def skip_new_action_tab?(controller_name, action)
    params[:controller] == controller_name && action == 'new'
  end
end
