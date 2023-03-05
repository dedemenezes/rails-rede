class AddFeaturedToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :featured, :boolean, default: false
  end
end
