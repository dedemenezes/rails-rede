class PagesController < ApplicationController

  def home
    @info_cards = [
      { img_name: 'binoculos', text: "11 observatórios na região da Bacia de Campos, onde há extração de petróleo e gás natural" },
      { img_name: 'lampada', text: "Monitoramos os conflitos vivenciados pelas comunidades para elaborar estratégias de intervenção" },
      { img_name: 'megafone', text: "Trabalhamos para mitigar os impactos da cadeia produtiva de petróleo e gás na Bacia de Campos" }
    ]
    @observatories = policy_scope(Observatory)
    @project = Project.includes(banner_attachment: :blob).first
    @markers = @observatories.geocoded.map do |observatory|
      {
        lat: observatory.latitude,
        lng: observatory.longitude,
        info_window: render_to_string(partial: 'observatories/info_window', locals: { observatory: }),
        image_url: helpers.asset_path('icon-pin--blue.svg')
      }
    end
    @galleries = Gallery.includes(:tags, banner_attachment: :blob).only_events
  end

  def create

  end

  def about_us
    @methodologies = Methodology.with_attached_banner.all
  end
end
