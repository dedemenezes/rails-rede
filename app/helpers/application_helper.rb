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
end
