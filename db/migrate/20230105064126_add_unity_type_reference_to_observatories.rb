class AddUnityTypeReferenceToObservatories < ActiveRecord::Migration[7.0]
  def change
    add_reference :observatories, :unity_type, null: false, foreign_key: true
  end
end
