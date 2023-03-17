class AddPublishedToAlbum < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :published, :boolean, default: false
  end
end
