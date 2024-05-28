class AddNameToVideos < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :name, :string
  end
end
