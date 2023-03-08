class CreateObservatoryPriorities < ActiveRecord::Migration[7.0]
  def change
    create_table :observatory_priorities do |t|
      t.references :observatory, null: true, foreign_key: true
      t.references :priority_type, null: true, foreign_key: true


      t.timestamps
    end
  end
end
