class DropCategories < ActiveRecord::Migration[7.0]
  def change
    reversible do |direction|
      direction.up do
        drop_table :categories, if_exists: true
      end

      direction.down do

        create_table :categories do |t|
          t.string :name

          t.timestamps
        end
      end
    end
  end
end
