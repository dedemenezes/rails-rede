class AddEmailToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :email, :string
  end
end
