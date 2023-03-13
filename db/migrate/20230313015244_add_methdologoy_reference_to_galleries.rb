class AddMethdologoyReferenceToGalleries < ActiveRecord::Migration[7.0]
  def change
    add_reference :galleries, :methodology, null: true, foreign_key: true
  end
end
