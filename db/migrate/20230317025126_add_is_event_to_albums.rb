class AddIsEventToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :is_event, :boolean, default: false
  end
end
