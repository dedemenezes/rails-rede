module Layouts
  module DashboardHelper
    def rendering_documents_or_images_or_videos?
      params[:action] =~ /document/ || params[:action] =~ /imag/ || params[:action] =~ /video/
    end

    def hide_nested_links(name_of_controller)
      name_of_controller == 'albums'
    end
  end
end
