class AddEventDateToGalleries < ActiveRecord::Migration[7.0]
  def change
    add_column :galleries, :event_date, :date
  end
end
