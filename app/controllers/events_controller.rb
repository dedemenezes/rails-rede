class EventsController < ApplicationController
  skip_after_action :verify_policy_scoped

  def index
    galleries = Gallery.includes(:tags, banner_attachment: :blob).only_published_events
    albums = Album.includes(:tags, banner_attachment: :blob).only_published_events
    @events = [galleries, albums].compact.flatten.sort_by(&:event_date).reverse
    @events = @events.select { |event| event.event_date.to_s <= params[:before_date] } if params[:before_date].present?
    respond_to do |format|
      format.html { redirect_to root_path(before_date: params[:before_date]) }
      format.text { render(partial: 'events/swiper', formats: [:html], locals: { events: @events }) }
    end
  end
end
