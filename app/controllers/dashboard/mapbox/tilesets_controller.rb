class Dashboard::Mapbox::TilesetsController < DashboardController
  def create
    begin
      response = MapboxUploader.tileset_from_kml(params[:name], params[:tileset].to_path)
    rescue S3::NotAuthorizedError => e
      response = e
    end

    respond_to do |format|
      format.json { render json: response.body, status: response.status }
    end
  end
end
