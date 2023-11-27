class AddMapboxOwnerToTilesets < ActiveRecord::Migration[7.0]
  def change
    add_column :tilesets, :mapbox_owner, :string
  end
end
