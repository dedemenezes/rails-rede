class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :url, null: false
      t.string :yt_id
      t.string :yt_username

      t.timestamps
    end
  end
end
