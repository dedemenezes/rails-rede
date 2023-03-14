class AddPublishedToMethodologies < ActiveRecord::Migration[7.0]
  def change
    add_column :methodologies, :published, :boolean, default: false
  end
end
