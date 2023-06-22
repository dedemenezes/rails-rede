class AddVideoIdToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :video_id, :string
  end
end
