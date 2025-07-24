class AddNavFeaturedToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :nav_featured, :boolean, default: false
  end
end
