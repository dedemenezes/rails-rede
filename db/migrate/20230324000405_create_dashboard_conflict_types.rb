class CreateDashboardConflictTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :dashboard_conflict_types do |t|

      t.timestamps
    end
  end
end
