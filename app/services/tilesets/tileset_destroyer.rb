module Tilesets
  class TilesetDestroyer
    attr_reader :tileset_id

    def initialize(tileset_id)
      @tileset_id = tileset_id
    end

    def run
      source_response = delete_source
      return unless source_response.status == 204

      delete_tileset
    end

    private

    def delete_tileset
      url = "/tilesets/v1/#{tileset_id}"
      conn = Faraday.new(url: "https://api.mapbox.com") do |faraday|
        faraday.adapter Faraday.default_adapter
      end
      conn.delete { |req| req.url "#{url}?access_token=#{ENV.fetch("MAPBOX_SUPER_KEY")}" }
    end

    def delete_source
      username, id = tileset_id.split('.')
      url  = "tilesets/v1/sources/#{username}/#{id}"

      conn = Faraday.new(url: "https://api.mapbox.com") do |faraday|
        faraday.adapter Faraday.default_adapter
      end
      conn.delete { |req| req.url "#{url}?access_token=#{ENV.fetch("MAPBOX_SUPER_KEY")}" }
    end
  end
end
