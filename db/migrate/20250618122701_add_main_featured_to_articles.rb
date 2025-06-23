class AddMainFeaturedToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :main_featured, :boolean, default: false
  end
end
