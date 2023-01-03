class CreateObservatoryConflicts < ActiveRecord::Migration[7.0]
  def change
    create_table :observatory_conflicts do |t|
      t.references :observatory, null: false, foreign_key: true
      t.references :conflict_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
