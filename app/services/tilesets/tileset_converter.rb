module Tilesets
  class TilesetConverter
    attr_reader :file_name

    def initialize(tileset_params)
      @tileset_params = tileset_params
      @file_name = Tileset.new.replace_non_ascii_with_ascii(@tileset_params[:kml].original_filename[...-4]).downcase.gsub(' ', '_')
    end

    def convert_geo_json_to_geo_json_ld
      # 1. Generate GeoJSON from geo_json sent
      original_file_name    = self.file_name
      geojson_string        = @tileset_params[:geo_json]
      geojson_file_path     = generate_geo_json_file(original_file_name, geojson_string)

      # 2. Convert GeoJSON to GeoJSONld
      generate_geo_json_ld_file(geojson_file_path, original_file_name)
    end

    private

    def generate_geo_json_file(file_name, geojson)
      geojson_with_icons_as_https = JSON.parse(geojson).map do |key, value|
        if key == 'features'
          value.map do |feature, f_value|
            if feature['properties']['icon'].present?
              feature['properties']['icon'].gsub!('http', 'https') unless feature['properties']['icon'].include?('https')
            end
            [feature, f_value]
          end.to_h
        end
        [key, value]
      end.to_h

      geojson_with_icons_as_https['features'].select { _1['properties']['icon'].present? }.each { |f| puts f['properties']['icon']}
      geojson_file_path = File.join(Rails.root.join('tmp', "#{file_name}.geojson"))
      File.open(geojson_file_path, 'w') { |file| file.write(geojson_with_icons_as_https.to_json) }
      geojson_file_path
    end

    def generate_geo_json_ld_file(geojson_file_path, output_file_name)
      features = decode_geojson(geojson_file_path)
      output_ldgeojson_path = File.join(Rails.root.join('tmp', "#{output_file_name}.geojsonld"))
      File.open(output_ldgeojson_path, 'w') do |ldgeojson_file|
        features.each do |feature|
          geojson_string = '{"type":"Feature","geometry":' + JSON.generate(RGeo::GeoJSON.encode(feature.geometry)) + ',"properties":' + feature.properties.to_json + '}'
          ldgeojson_file.puts(geojson_string)
        end
      end

      # remove geojson file if we have a converted version
      File.delete(geojson_file_path) if File.exist?(output_ldgeojson_path) && File.exist?(geojson_file_path)
      output_ldgeojson_path
    end


    def decode_geojson(geojson_file_path)
      geojson_content = File.read(geojson_file_path)
      RGeo::GeoJSON.decode(geojson_content, json_parser: :json)
    end
  end
end
