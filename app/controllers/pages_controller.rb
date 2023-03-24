class PagesController < ApplicationController

  def home
    @info_cards = [
      { img_name: 'binoculo', text: "11 observatórios na região da Bacia de Campos, onde há extração de petróleo e gás natural" },
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
    @galleries = Gallery.includes(:tags, banner_attachment: :blob).only_published_events
    @albums = Album.includes(:tags, banner_attachment: :blob).only_published_events
    @events = [@galleries, @albums].compact.flatten.sort_by(&:event_date).reverse

    if params[:from_date].present?
      @events = @events.select { |event| event.event_date.to_s > params[:from_date] }.sort_by(&:updated_at).reverse
    end
    @featured = Article.featured
    @articles = Article.where(published: true, featured: false).order(updated_at: :desc).limit(4)
  end

  def about_us
    @methodologies = Methodology.with_attached_banner.all
    @project = Project.includes(slide_one_attachment: :blob, slide_two_attachment: :blob, slide_three_attachment: :blob).first
    @photos = [@project.slide_one, @project.slide_two, @project.slide_three]
    @text_colors = ['rede-primary', 'rede-dark-red', 'rede-primary-l']
  end
end
