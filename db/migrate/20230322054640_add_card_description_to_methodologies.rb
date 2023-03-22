class AddCardDescriptionToMethodologies < ActiveRecord::Migration[7.0]
  def change
    add_column :methodologies, :card_description, :string
  end
end
