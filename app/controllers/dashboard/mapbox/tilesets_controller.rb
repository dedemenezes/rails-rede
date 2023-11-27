class Dashboard::Mapbox::TilesetsController < DashboardController
  def new
    @dashboard_tileset = Tileset.new
    authorize [:dashboard, current_user]
  end

  def create
    @dashboard_tileset = Tileset.new(tileset_params)
    respond_to do |format|
      if @dashboard_tileset.save
        rename_kml_blob
        upload_tileset_to_mapbox
        format.html do
          flash[:notice] = 'Tileset created!'
          redirect_to home_path
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
      format.json { render json: @response.body, status: @response.status }
    end
  end

  private

  def upload_tileset_to_mapbox
    begin
      @response = MapboxUploader.tileset_from_kml(@dashboard_tileset.mapbox_id, tileset_params[:kml].path)
    rescue S3::NotAuthorizedError => e
      @response = e
    end
  end

  def rename_kml_blob
    @dashboard_tileset.kml.blob.filename = ActiveStorage::Filename.new(Tileset.new
                                              .replace_non_ascii_with_ascii(
                                                @dashboard_tileset.kml.blob.filename.to_s.downcase
                                              ))
    @dashboard_tileset.kml.blob.save
  end

  def tileset_params
    params.require(:tileset).permit(:name, :kml)
  end
end
