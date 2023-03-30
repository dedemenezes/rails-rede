class EventsController < ApplicationController
  def index
    galleries = Gallery.includes(:tags, banner_attachment: :blob).only_published_events
    albums = Album.includes(:tags, banner_attachment: :blob).only_published_events
    @events = [galleries, albums].compact.flatten.sort_by(&:event_date).reverse
    @events = @events.select { |event| event.event_date.to_s > params[:before_date] } if params[:before_date].present?
    respond_to do |format|
      format.text { render(partial: 'swiper', format: [:html], locals: { events: @events }) }
    end
  end
end
