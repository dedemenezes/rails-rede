class AddMethodologyReferenceToArticles < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :methodology, null: true, foreign_key: true
  end
end
