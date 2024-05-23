class AddCategoryToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :category, :string
  end
end
