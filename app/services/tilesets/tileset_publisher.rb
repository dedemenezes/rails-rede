module Tilesets
  class TilesetPublisher
    ACCESS_TOKEN = ENV.fetch("MAPBOX_SUPER_KEY")
    USERNAME = "dedemenezes"

    def initialize(output_ldgeojson_path)
      @output_ldgeojson_path = output_ldgeojson_path
    end

    def create_and_publish_tileset!(id)

      tileset_id = "#{USERNAME}.#{id}"

      # 3. Create a tileset source
      r = create_tileset_source(id, @output_ldgeojson_path)
      puts "### RESPONSE FROM TILSET SOURCE ####"
      p r.body

      # 4. Write a recipe and create Tileset
      # Replace '{tileset_id}' with your actual tileset ID
      tilset_source = JSON.parse(r.body)["id"]

      r = create_tileset_with_recipe(tilset_source, id, tileset_id)
      puts "### RESPONSE FROM TILESET W/ RECIPE ####"
      p r.body
      # 6. Publish your new tileset
      r = publish_tileset(tileset_id)
      puts "### RESPONSE FROM TILESET PUBLISH! ####"
      p r.body
    end


    private

    def publish_tileset(tileset_id)
      conn = Faraday.new(url: "https://api.mapbox.com") do |faraday|
        faraday.adapter Faraday.default_adapter
      end

      conn.post { |req| req.url "/tilesets/v1/#{tileset_id}/publish?access_token=#{ACCESS_TOKEN}" }
    end

    def create_tileset_with_recipe(tilset_source, id, tileset_id)
      recipe_and_instructions_file_path = File.join(Rails.root.join('lib', 'tileset-information-and-recipe.json'))
      tileset_info_recipe_file_path = recipe_and_instructions_file_path
      tileset_info_recipe_content = File.read(tileset_info_recipe_file_path)
      info_and_recipe = JSON.parse(tileset_info_recipe_content)

      info_and_recipe['name'] = id
      info_and_recipe['recipe']['layers']['inspections-points']['source'] = tilset_source
      info_and_recipe['recipe']['layers']['inspections-areas']['source'] = tilset_source
      # Write into same file
      File.open(recipe_and_instructions_file_path, 'w') { |file| file.write(JSON.generate(info_and_recipe)) }
      updated_tileset_info_recipe_content = File.read(recipe_and_instructions_file_path)

      conn = Faraday.new(url: "https://api.mapbox.com") do |faraday|
        faraday.adapter Faraday.default_adapter
      end

      conn.post do |req|
        req.url "/tilesets/v1/#{tileset_id}"
        req.headers['Content-Type'] = 'application/json'
        req.params['access_token'] = ACCESS_TOKEN
        req.body = updated_tileset_info_recipe_content
      end
    end

    # rubocop:disable Metrics/MethodLength
    def create_tileset_source(id, file_path)
      # Create a Faraday connection
      conn = Faraday.new(url: 'https://api.mapbox.com') do |faraday|
        faraday.request :multipart
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end

      # Make the request
      conn.post do |req|
        req.url "/tilesets/v1/sources/#{USERNAME}/#{id}"
        req.headers['Content-Type'] = 'multipart/form-data'
        req.params['access_token'] = ACCESS_TOKEN
        req.body = { file: Faraday::UploadIO.new(file_path, 'application/octet-stream') }
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
