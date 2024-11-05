class DropObservatoryCategories < ActiveRecord::Migration[7.0]
  def change
    reversible do |direction|
      direction.up do
        drop_table :observatory_categories
      end

      direction.down do
        create_table :observatory_categories do |t|
          t.references :observatory, null: false, foreign_key: true
          t.references :category, null: false, foreign_key: true

          t.timestamps
        end
      end
    end
  end
end
