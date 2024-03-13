class ObservatoriesController < ApplicationController
  def index
    @observatories = policy_scope(Observatory).includes(banner_attachment: :blob).order(name: :asc)
    @markers = @observatories.map do |observatory|
      {
        lat: observatory.latitude,
        lng: observatory.longitude
      }
    end
  end

  def show
    @observatory = Observatory.includes(
      :priority_subjects,
      :conflict_types,
      :gallery,
      banner_attachment: :blob,
      albums: [
        :tags,
        {
          photos_attachments: :blob,
          banner_attachment: :blob
        }
      ]
    ).find_by(name: params[:name]) || Observatory.find(params[:id])
    gallery = @observatory.gallery
    # @photos = albums.map { |album| album.photos.sample(1)[0] }
    @photos = @observatory.albums.map(&:photos).flatten.sample(11)
    @photos << gallery.banner

    @articles = Article.includes(:tags, :rich_text_rich_body,
                                 banner_attachment: :blob).find_by_writer(@observatory.name).sort_by(&:updated_at).reverse.take(5)
    @featured = @articles.shift

    @tileset = load_tileset

    authorize @observatory
  end

  def mapa
    @tilesets = Tilesets::TilesetService.load_all
    authorize Observatory
  end

  private

  def load_tileset
    tileset = Tileset.find_by_name(@observatory.name)

    tileset ? [Tilesets::TilesetService.load_one(tileset)] : []
  end
end
