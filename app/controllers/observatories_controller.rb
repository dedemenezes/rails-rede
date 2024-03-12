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
    @markers = [
      {
        lat: @observatory.latitude,
        lng: @observatory.longitude,
        info_window: render_to_string(partial: 'observatories/info_window', locals: { observatory: @observatory }),
        image_url: helpers.asset_path('icon-pin--blue.svg')
      }
    ]
    @articles = Article.includes(:tags, :rich_text_rich_body,
                                 banner_attachment: :blob).find_by_writer(@observatory.name).sort_by(&:updated_at).reverse.take(5)
    @featured = @articles.shift
    authorize @observatory
  end

  def mapa
    @observatories = policy_scope(Observatory).includes(:conflict_types, :priority_subjects, banner_attachment: :blob).where.not(
      latitude: nil, longitude: nil
    )
    @markers = @observatories.map do |observatory|
      {
        lat: observatory.latitude,
        lng: observatory.longitude,
        info_window: render_to_string(partial: 'info_window', locals: { observatory: }),
        image_url: helpers.asset_path('icon-pin--blue.svg')
      }
    end
    @tilesets = Tileset.all.map do |tileset|
      geo_json = JSON.parse(tileset.geo_json)
      features = geo_json['features']
      points = features.select { |f| f['geometry']['type'] == 'Point' }
      icons = points.uniq { |f| f['properties']['icon'] }
                    .map { |f| f['properties']['icon'] }
      {
        sourceValue: tileset.mapbox_id,
        urlValue: "mapbox://dedemenezes.#{tileset.mapbox_id}",
        geoJson: tileset.geo_json,
        icons:
      }
    end
  end
end
