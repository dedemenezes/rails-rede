class CreateGalleries < ActiveRecord::Migration[7.0]
  def change
    create_table :galleries do |t|
      t.string :name
      t.references :observatory, null: true, foreign_key: true
      t.string :category

      t.timestamps
    end
  end
end
