class CreateObservatoryPrioritySubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :observatory_priority_subjects do |t|
      t.references :priority_type, null: false, foreign_key: true
      t.references :observatory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
