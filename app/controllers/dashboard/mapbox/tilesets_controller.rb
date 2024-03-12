require 'rgeo'

module Dashboard
  module Mapbox
    class TilesetsController < DashboardController
      skip_before_action :add_default_dashboard_breadcrumb

      def index
        @tilesets = Tileset.all
      end

      def new
        @dashboard_tileset = Tileset.new
        authorize [:dashboard, current_user]
      end

      def create
        @dashboard_tileset = Tileset.new(tileset_params)

        if @dashboard_tileset.save
          upload_tileset_geojson_with_recipe
          flash[:notice] = 'Tileset created!'
          redirect_to home_path
        else
          render :new, status: :unprocessable_entity
        end
      end

      def edit
        @dashboard_tileset = Tileset.find(params[:id])
      end

      def update
        @dashboard_tileset = Tileset.find(params[:id])
        # @dashboard_tileset.update(tileset_params)
        respond_to do |format|
          if @dashboard_tileset.save
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
        response = Tilesets::TilesetService.new(@dashboard_tileset.full_tileset_id)
                                           .delete_from_mapbox

        if response.status == 200
          @dashboard_tileset.destroy
          flash[:notice] = 'Tileset removido!'
          redirect_to dashboard_mapbox_tilesets_path, status: :see_other
        else
          Rails.logger.debug "ERROR - [STATUS] - #{response.status} - [BODY] - #{response.body}"
          flash[:alert] = 'Não foi possível remover'
          redirect_to dashboard_mapbox_tilesets_path
        end
      end

      private

      def upload_tileset_geojson_with_recipe
        tileset_service = Tilesets::TilesetService.new(params[:tileset])
        tileset_service.upload_and_publish_tileset
      end

      def tileset_params
        params.require(:tileset).permit(:name, :kml, :geo_json)
      end
    end
  end
end
