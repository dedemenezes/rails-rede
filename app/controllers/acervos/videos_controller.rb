module Acervos
  class VideosController < ApplicationController
    def index
      @videos = policy_scope(Video)
    end

    def with_modal
      @videos = policy_scope(Video)
    end
  end
end
