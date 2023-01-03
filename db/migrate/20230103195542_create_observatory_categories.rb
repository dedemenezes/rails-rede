class CreateObservatoryCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :observatory_categories do |t|
      t.references :observatory, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
