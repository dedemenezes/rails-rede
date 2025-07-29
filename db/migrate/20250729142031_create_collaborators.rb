class CreateCollaborators < ActiveRecord::Migration[7.0]
  def change
    create_table :collaborators do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.string :occupation
      t.text :testimonial, null: false

      t.timestamps
    end
  end
end
