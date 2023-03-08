class ChangeDescriptionInObservatories < ActiveRecord::Migration[7.0]
  def change
    remove_column :observatories, :description
    add_column :observatories, :description, :text
  end
end
