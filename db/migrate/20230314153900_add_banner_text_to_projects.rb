class AddBannerTextToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :banner_text, :string
  end
end
