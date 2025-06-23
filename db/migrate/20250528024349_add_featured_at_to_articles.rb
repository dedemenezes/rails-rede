class AddFeaturedAtToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :featured_at, :datetime
  end
end
