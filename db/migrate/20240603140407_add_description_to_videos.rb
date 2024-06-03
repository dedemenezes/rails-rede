class AddDescriptionToVideos < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :description, :string
  end
end
