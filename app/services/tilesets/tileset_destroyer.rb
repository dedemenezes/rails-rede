module Tilesets
  class TilesetDestroyer
    attr_reader :tileset_id

    def initialize(tileset_id)
      @tileset_id = tileset_id
    end

    def run
      url = "/tilesets/v1/#{tileset_id}"
      conn = Faraday.new(url: "https://api.mapbox.com") do |faraday|
        faraday.adapter Faraday.default_adapter
      end
      conn.delete { |req| req.url "#{url}?access_token=#{ENV.fetch("MAPBOX_SUPER_KEY")}" }
    end

  end
end
