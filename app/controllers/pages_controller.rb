class PagesController < ApplicationController

  def home
    @info_cards = [
      { img_name: 'binoculos', text: "11 observatórios na região da Bacia de Campos, onde há extração de petróleo e gás natural" },
      { img_name: 'lampada', text: "Monitoramos os conflitos vivenciados pelas comunidades para elaborar estratégias de intervenção" },
      { img_name: 'megafone', text: "Trabalhamos para mitigar os impactos da cadeia produtiva de petróleo e gás na Bacia de Campos" }
    ]
    @observatories = policy_scope(Observatory).where.not(latitude: nil, longitude: nil)
    @project = Project.includes(banner_attachment: :blob).first
    @markers = @observatories.map do |observatory|
      {
        lat: observatory.latitude,
        lng: observatory.longitude,
        info_window: render_to_string(partial: 'observatories/info_window', locals: { observatory: }),
        image_url: helpers.asset_path('icon-pin--blue.svg')
      }
    end
    @galleries = Gallery.includes(:tags, banner_attachment: :blob).only_events
    @albums = Album.includes(:tags, banner_attachment: :blob).only_events
    @events = [@galleries, @albums].flatten
  end

  def about_us
    @methodologies = Methodology.with_attached_banner.all
    @photos = Project.includes(photos_attachments: :blob).first.photos
    @text_colors = ['rede-primary', 'rede-dark-red', 'rede-primary-l']
  end
end
