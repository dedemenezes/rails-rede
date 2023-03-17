class AddEventDateToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :event_date, :date
  end
end
