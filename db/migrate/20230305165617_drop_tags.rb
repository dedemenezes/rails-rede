class DropTags < ActiveRecord::Migration[7.0]
  def change
    drop_table :tags, foreing_key: true
  end
end
