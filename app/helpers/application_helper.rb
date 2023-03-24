module ApplicationHelper

  def model_name_from_controller_name(controller_name_to_use)
    controller_name_to_use.singularize.split('_').map(&:capitalize).join.constantize
  end

  def tab_active?(expected, options = {})
    condition = params[:controller] == expected
    if params[:controller] == 'pages' || params[:controller] == 'observatories' || params[:controller] == 'contacts'
      condition = params[:action] == options[:action] && params[:controller] == expected
    end
    condition ? 'active' : ''
  end

  def display_banner_as_background(instance)
    if instance.banner.attached?
      "https://rede-observacao-prod.s3.us-east-2.amazonaws.com/#{instance.banner.key}"
    else
      image_path('default-banner.png')
    end
  end

  def display_banner_image(photo, options = {})
    if photo.attached?
      url = "https://rede-observacao-prod.s3.us-east-2.amazonaws.com/#{photo.key}"
    else
      url = 'default-banner.png'
    end
    image_tag(url, options)
  end

  def display_banner_as_background_image(photo, options = {})
    if photo.attached?
      url = "https://rede-observacao-prod.s3.us-east-2.amazonaws.com/#{photo.key}"
    else
      url = 'default-banner.png'
    end
    image_path(url, options)
  end

  def display_banner(instance, options = {})
    if instance.banner.attached?
      url = "https://rede-observacao-prod.s3.us-east-2.amazonaws.com/#{instance.banner.key}"
    else
      url = 'default-banner.png'
    end
    image_tag(url, options)
  end

  def route_for_edit_dashboard(element)
    "#{element.model_name.plural}/#{element.id}/edit"
  end

  def hide_nested_links(name_of_controller)
    name_of_controller == 'albums'
  end

  def skip_new_action_tab?(controller_name, action)
    params[:controller] == controller_name && action == 'new'
  end
end
