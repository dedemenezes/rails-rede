class CreateConflictTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :conflict_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
