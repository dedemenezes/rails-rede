class PagesController < ApplicationController
  def home
    @project = Project.first

    load_info_cards
    load_events
    load_articles
    load_tilesets
  end

  def about_us
    @methodologies = Methodology.with_attached_banner.all
    @project = Project.includes(
      slide_one_attachment: :blob,
      slide_two_attachment: :blob,
      slide_three_attachment: :blob
    ).first
    @photos = [@project.slide_one, @project.slide_two, @project.slide_three]
    @text_colors = ['rede-primary', 'rede-dark-red', 'rede-primary-l']
  end

  private

  def load_articles
    @featured = Article.featured
    @articles = Article.includes([:tags], banner_attachment: :blob)
                       .where(published: true, featured: false)
                       .order(updated_at: :desc)
                       .limit(4)
  end

  def load_events
    galleries = Gallery.only_published_events
    albums = Album.only_published_events
    @events = [galleries, albums].compact.flatten.sort_by(&:event_date).reverse
    @events = @events.select { |event| event.event_date.to_s <= params[:before_date] } if params[:before_date].present?
  end

  def load_tilesets
    @tilesets = Tileset.all.map do |tileset|
      Tilesets::TilesetService.new(tileset).present
    end
  end

  def load_info_cards
    @info_cards = [
      { img_name: 'binoculo',
        text: "11 observatórios na região da Bacia de Campos, onde há extração de petróleo e gás natural" },
      { img_name: 'lampada',
        text: "Monitoramos os conflitos vivenciados pelas comunidades para elaborar estratégias de intervenção" },
      { img_name: 'megafone',
        text: "Trabalhamos para mitigar os impactos da cadeia produtiva de petróleo e gás na Bacia de Campos" }
    ]
  end
end
