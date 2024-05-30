class RemoveAlbumReferenceFromVideos < ActiveRecord::Migration[7.0]
  def change
    remove_reference :videos, :album, null: false, foreign_key: true
  end
end
