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

    # respond_to do |format|
      if @dashboard_tileset.save
        upload_tileset_geojson_with_recipe
    #     rename_kml_blob
    #     upload_tileset_to_mapbox
    #     data = JSON.parse @response.body
    #     @dashboard_tileset.mapbox_id = data['name'] if data['name']
    #     @dashboard_tileset.mapbox_owner = data['owner'] if data['owner']
    #     @dashboard_tileset.save
    #     format.html do
          flash[:notice] = 'Tileset created!'
          redirect_to home_path
    #     end
      else
        render :new, status: :unprocessable_entity
      end
    #   format.json { render json: @response.body, status: @response.status }
    # end
  end

  def edit
    @dashboard_tileset = Tileset.find(params[:id])
  end

  def update
    @dashboard_tileset = Tileset.find(params[:id])
    # @dashboard_tileset.update(tileset_params)
    respond_to do |format|
      if @dashboard_tileset.save
        # rename_kml_blob
        # upload_tileset_to_mapbox
        # data = JSON.parse @response.body
        # @dashboard_tileset.mapbox_id = data['name'] if data['name']
        # @dashboard_tileset.mapbox_owner = data['owner'] if data['owner']
        # @dashboard_tileset.save
        format.html do
          flash[:notice] = 'Tileset updated!'
          redirect_to home_path
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
      format.json { render json: @response.body, status: @response.status }
    end
  end

  def destroy
    @dashboard_tileset = Tileset.find(params[:id])
    @dashboard_tileset.destroy
    redirect_to dashboard_mapbox_tilesets_path, status: :see_other
  end

  private

  def upload_tileset_geojson_with_recipe
    tileset_service = Tilesets::TilesetService.new(params[:tileset])
    tileset_service.upload_and_publish_tileset
  end

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
