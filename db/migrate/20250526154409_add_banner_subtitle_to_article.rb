class AddBannerSubtitleToArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :banner_subtitle, :string
  end
end
