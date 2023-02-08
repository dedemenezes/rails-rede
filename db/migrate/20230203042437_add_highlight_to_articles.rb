class AddHighlightToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :highlight, :string
  end
end
