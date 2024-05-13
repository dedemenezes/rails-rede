module Tilesets
  class TilesetLoader
    def run
      Tileset.all.map do |tileset|
        present(tileset)
      end
    end

    def present(tileset)
      geo_json = JSON.parse(tileset.geo_json)
      features = geo_json['features']
      points = features.select { |f| f['geometry']['type'] == 'Point' }
      icons = points.uniq { |f| f['properties']['icon'] }.map { |f| f['properties']['icon'] }

      {
        sourceValue: tileset.mapbox_id,
        urlValue: "mapbox://#{ENV.fetch('MAPBOX_USERNAME')}.#{tileset.mapbox_id}",
        geoJson: tileset.geo_json,
        icons:
      }
    end
  end
end
