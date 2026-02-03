class Navbar::VideosController < ApplicationController
  def index
    @nav_videos = policy_scope(Video).order(created_at: :desc).limit(2)
    render partial: "shared/nav_videos", locals: { nav_videos: @nav_videos }
  end
end
