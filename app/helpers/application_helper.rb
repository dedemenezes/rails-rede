module ApplicationHelper
  # SET DASHBOARD HEADER TITLE
  def dashboard_header_title_tag(klass)
    klass_name = klass.model_name.human
    klass_name = "Imagens" if params[:action] == 'imagens'
    klass_name = "Materiais" if params[:controller].match?(/materials/)
    "<h1>#{klass_name}</h1>".html_safe
  end

  def query_string_except(tag, tags)
    params[:search].permit(tags.map(&:name).map(&:downcase).map(&:to_sym)).except(tag)
  end

  def model_name_from_controller_name(controller_name_to_use)
    return Album if controller_name.match?(/materials/)

    controller_name_to_use.singularize.split('_').map(&:capitalize).join.constantize
  end

  def tab_active?(expected, options = {})
    condition = params[:controller] == expected
    if params[:controller] == 'pages' || params[:controller] == 'observatories' || params[:controller] == 'contacts' || params[:controller] == 'galleries'
      condition = params[:action] == options[:action] && params[:controller] == expected
    end
    condition ? 'active' : 'fw-normal'
  end

  def display_banner_as_background(instance)
    # if Rails.env.development?
    #   cl_image_path(instance.banner.key)
    # else
      if instance&.banner&.attached?
        "https://rede-observacao-prod.s3.us-east-2.amazonaws.com/#{instance.banner.key}"
      else
        image_path('default-banner.png')
      end
    # end
  end

  def display_banner_image(photo, options = {})
    # if Rails.env.development?
    #   cl_image_tag(photo.key, width: options[:width], style: options[:style])
    # else
      if photo.attached?
        url = "https://rede-observacao-prod.s3.us-east-2.amazonaws.com/#{photo.key}"
      else
        url = 'default-banner.png'
      end
      image_tag(url, options)
    # end
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
    param = element.is_a?(Article) ? element.header : element.id
    path = "#{element.model_name.plural}/#{param}/edit"
    return path unless element.is_a? Album

    path.gsub(%r{^albums/}, '')
  end

  def route_for_destroy_dashboard(element)
    path = "#{element.model_name.plural}/#{element.id}"
    return path unless element.is_a? Album

    path.gsub(%r{^albums/}, '')
  end

  def skip_new_action_tab?(controller_name, action)
    params[:controller] == controller_name && action == 'new'
  end
end
