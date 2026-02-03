class AddNavFeaturedToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :main_featured, :boolean, default: false
  end
end
