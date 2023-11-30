class AddGeoJsonToTilesets < ActiveRecord::Migration[7.0]
  def change
    add_column :tilesets, :geo_json, :json, default: {}
  end
end
