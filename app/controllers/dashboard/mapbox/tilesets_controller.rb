class Dashboard::Mapbox::TilesetsController < DashboardController
  def create
    binding.b
    response = MapboxUploader.tileset_from_kml(params[:name], params[:tileset].to_path)
    respond_to do |format|
      format.json { render json: response.body }
    end
  end
end
