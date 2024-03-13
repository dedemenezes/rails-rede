module Tilesets
  class TilesetService
    def initialize(tileset_params = nil)
      @tileset_params = tileset_params
    end

    def upload_and_publish_tileset
      tileset_converter = TilesetConverter.new(@tileset_params)
      output_ldgeojson_path = tileset_converter.convert_geo_json_to_geo_json_ld
      file_name = tileset_converter.file_name

      tileset_publisher = TilesetPublisher.new(output_ldgeojson_path)
      tileset_publisher.create_and_publish_tileset!(file_name)
    end

    def delete_from_mapbox
      tileset_destroyer = TilesetDestroyer.new(@tileset_params)
      tileset_destroyer.run
    end

    def present
      geo_json = JSON.parse(@tileset_params.geo_json)
      features = geo_json['features']
      points = features.select { |f| f['geometry']['type'] == 'Point' }
      icons = points.uniq { |f| f['properties']['icon'] }.map { |f| f['properties']['icon'] }
      {
        sourceValue: @tileset_params.mapbox_id,
        urlValue: "mapbox://dedemenezes.#{@tileset_params.mapbox_id}",
        geoJson: @tileset_params.geo_json,
        icons:
      }
    end
  end
end
