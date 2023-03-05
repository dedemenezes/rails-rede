class DropArticleTags < ActiveRecord::Migration[7.0]
  def change
    drop_table :article_tags, foreing_key: true
  end
end
