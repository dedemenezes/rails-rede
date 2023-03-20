class RemovePriorityTypeReferenceFromObservatories < ActiveRecord::Migration[7.0]
  def change
    remove_reference :observatories, :priority_type, null: false, foreign_key: true
  end
end
