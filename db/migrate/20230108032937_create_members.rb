class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :description
      t.string :occupation
      t.string :role
      t.boolean :published
      t.references :observatory, null: true, foreign_key: true
      t.references :project, null: true, foreign_key: true

      t.timestamps
    end
  end
end
