class AddVisibleToTaggings < ActiveRecord::Migration[7.0]
  def change
    add_column :taggings, :visible, :boolean, null: false, default: false
  end
end
