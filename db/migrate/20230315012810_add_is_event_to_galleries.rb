class AddIsEventToGalleries < ActiveRecord::Migration[7.0]
  def change
    add_column :galleries, :is_event, :boolean, default: false
  end
end
