module Tilesets
  class TilesetService
    def initialize(tileset_params)
      @tileset_params = tileset_params
    end

    def upload_and_publish_tileset
      tileset_converter = TilesetConverter.new(@tileset_params)
      output_ldgeojson_path = tileset_converter.convert_geo_json_to_geo_json_ld
      file_name = tileset_converter.file_name
      debugger

      tileset_publisher = TilesetPublisher.new(output_ldgeojson_path)
      debugger
      tileset_publisher.create_and_publish_tileset!(file_name)
    end
  end
end
