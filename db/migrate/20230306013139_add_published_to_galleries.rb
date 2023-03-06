class AddPublishedToGalleries < ActiveRecord::Migration[7.0]
  def change
    add_column :galleries, :published, :boolean, default: false
  end
end
