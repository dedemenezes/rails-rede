class AddPriorityTypeReferenceToObservatories < ActiveRecord::Migration[7.0]
  def change
    add_reference :observatories, :priority_type, null: true, foreign_key: true
  end
end
