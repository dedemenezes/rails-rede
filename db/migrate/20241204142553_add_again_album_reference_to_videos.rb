class AddAgainAlbumReferenceToVideos < ActiveRecord::Migration[7.0]
  def change
    add_reference :videos, :album, foreign_key: true
  end
end
