require 'rgeo'

class Dashboard::Mapbox::TilesetsController < DashboardController
  def index
    @tilesets = Tileset.all
  end

  def new
    @dashboard_tileset = Tileset.new
    authorize [:dashboard, current_user]
  end

  def create
    @dashboard_tileset = Tileset.new(tileset_params)

    upload_tileset_geojson_with_recipe
    # respond_to do |format|
    #   if @dashboard_tileset.save
    #     rename_kml_blob
    #     upload_tileset_to_mapbox
    #     data = JSON.parse @response.body
    #     @dashboard_tileset.mapbox_id = data['name'] if data['name']
    #     @dashboard_tileset.mapbox_owner = data['owner'] if data['owner']
    #     @dashboard_tileset.save
    #     format.html do
    #       flash[:notice] = 'Tileset created!'
    #       redirect_to home_path
    #     end
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #   end
    #   format.json { render json: @response.body, status: @response.status }
    # end
  end

  def edit
    @dashboard_tileset = Tileset.find(params[:id])
  end

  def update
    @dashboard_tileset = Tileset.find(params[:id])
    # @dashboard_tileset.update(tileset_params)
    upload_tileset_geojson_with_recipe
    # respond_to do |format|
    #   if @dashboard_tileset.save
    #     rename_kml_blob
    #     upload_tileset_to_mapbox
    #     data = JSON.parse @response.body
    #     @dashboard_tileset.mapbox_id = data['name'] if data['name']
    #     @dashboard_tileset.mapbox_owner = data['owner'] if data['owner']
    #     @dashboard_tileset.save
    #     format.html do
    #       flash[:notice] = 'Tileset updated!'
    #       redirect_to home_path
    #     end
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #   end
    #   format.json { render json: @response.body, status: @response.status }
    # end
  end

  def destroy
    @dashboard_tileset = Tileset.find(params[:id])
    @dashboard_tileset.destroy
    redirect_to dashboard_mapbox_tilesets_path, status: :see_other
  end

  private

  def upload_tileset_geojson_with_recipe
    # 1. Generate GeoJSON from geo_json sent
    file_name             = Tileset.new.replace_non_ascii_with_ascii(params[:tileset][:kml].original_filename[...-4]).downcase.gsub(' ', '_')
    geojson_string        = params[:tileset][:geo_json]
    geojson_file_path     = generate_geo_json_file(file_name, geojson_string)

    # 2. Convert GeoJSON to GeoJSONld
    output_ldgeojson_path = generate_geo_json_ld_file(geojson_file_path, file_name)
    debugger


    access_token = ENV.fetch("MAPBOX_SUPER_KEY")
    id = file_name
    username = "dedemenezes"
    tileset_id = "#{username}.#{id}"

    # 3. Create a tileset source
    r = create_tileset_source(id, username, output_ldgeojson_path, access_token)
    # {"id":"mapbox://tileset-source/dedemenezes/hello-world","files":1,"source_size":148050,"file_size":148050}
    debugger

    # 4. Write a recipe and create Tileset
    # Replace '{tileset_id}' with your actual tileset ID
    tilset_source = JSON.parse(r.body)["id"]
    r = create_tileset_with_recipe(tilset_source, id, tileset_id, access_token)
    debugger

    # 6. Publish your new tileset
    r = publish_tileset(tileset_id, access_token)
    debugger
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

  def generate_geo_json_file(file_name, geojson)
    geojson_file_path = File.join(Rails.root.join('tmp', "#{file_name}.geojson"))
    File.open(geojson_file_path, 'w') { |file| file.write(geojson) }
    geojson_file_path
  end

  def publish_tileset(tileset_id, access_token)
    conn = Faraday.new(url: "https://api.mapbox.com") do |faraday|
      faraday.adapter Faraday.default_adapter
    end
    response = conn.post do |req|
      req.url "/tilesets/v1/#{tileset_id}/publish?access_token=#{access_token}"
    end
    p response.body
    response
  end

  def create_tileset_with_recipe(tilset_source, id, tileset_id, access_token)
    recipe_and_instructions_file_path = File.join(Rails.root.join('lib', 'tileset-information-and-recipe.json'))
    tileset_info_recipe_file_path = recipe_and_instructions_file_path
    tileset_info_recipe_content = File.read(tileset_info_recipe_file_path)
    info_and_recipe = JSON.parse(tileset_info_recipe_content)
    info_and_recipe['name'] = id
    info_and_recipe['recipe']['layers']['inspections-points']['source'] = tilset_source
    # Write into same file
    File.open(recipe_and_instructions_file_path, 'w') { |file| file.write(JSON.generate(info_and_recipe)) }

    debugger
    conn = Faraday.new(url: "https://api.mapbox.com") do |faraday|
      faraday.adapter Faraday.default_adapter
    end
    response = conn.post do |req|
      req.url "/tilesets/v1/#{tileset_id}"
      req.headers['Content-Type'] = 'application/json'
      req.params['access_token'] = access_token
      req.body = tileset_info_recipe_content
    end
    p response.body
    response
  end

  # rubocop:disable Metrics/MethodLength
  def create_tileset_source(id, username, file_path, access_token)
    # Create a Faraday connection
    conn = Faraday.new(url: 'https://api.mapbox.com') do |faraday|
      faraday.request :multipart
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end

    # Make the request
    response = conn.post do |req|
      req.url "/tilesets/v1/sources/#{username}/#{id}"
      req.headers['Content-Type'] = 'multipart/form-data'
      req.params['access_token'] = access_token
      req.body = { file: Faraday::UploadIO.new(file_path, 'application/octet-stream') }
    end
    p response.body
    response
  end
  # rubocop:enable Metrics/MethodLength

  def upload_tileset_to_mapbox
    begin
      @response = MapboxUploader.tileset_from_kml(@dashboard_tileset.name, tileset_params[:kml].path)
    rescue S3::NotAuthorizedError => e
      @response = e
    end
  end

  def rename_kml_blob
    @dashboard_tileset.kml.blob.filename = ActiveStorage::Filename.new(Tileset.new
                                              .replace_non_ascii_with_ascii(
                                                @dashboard_tileset.kml.blob.filename.to_s
                                              ))
    @dashboard_tileset.kml.blob.save
  end

  def tileset_params
    params.require(:tileset).permit(:name, :kml, :geo_json)
  end
end
