class AddSlideShowSubtitlesToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :slide_one_subtitle, :string
    add_column :projects, :slide_two_subtitle, :string
    add_column :projects, :slide_three_subtitle, :string
  end
end
