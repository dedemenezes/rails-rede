class AddContentTextColumnsToMethodologies < ActiveRecord::Migration[7.0]
  def change
    add_column :methodologies, :header_one, :string
    add_column :methodologies, :description_one, :string
    add_column :methodologies, :header_two, :string
    add_column :methodologies, :description_two, :string
  end
end
