class AddSocialUrlsToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :yt_url, :string
    add_column :projects, :fb_url, :string
    add_column :projects, :ig_url, :string
  end
end
