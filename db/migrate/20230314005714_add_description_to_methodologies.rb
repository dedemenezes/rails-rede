class AddDescriptionToMethodologies < ActiveRecord::Migration[7.0]
  def change
    add_column :methodologies, :description, :text
  end
end
