class AddObservatoryReferenceToArticles < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :observatory, null: true, foreign_key: true
  end
end
