class DropObservatoryPriorities < ActiveRecord::Migration[7.0]
  def change
    drop_table :observatory_priorities
  end
end
