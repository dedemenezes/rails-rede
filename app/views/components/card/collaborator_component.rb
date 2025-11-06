# frozen_string_literal: true

class Card::CollaboratorComponent < ApplicationComponent
  include Phlex::Rails::Helpers::ImageTag
  include Phlex::Rails::Helpers::Routes

  attr_reader :id, :name, :image_url, :location, :color, :occupation

  def initialize(id:, name:, image_url:, location:, color:, occupation:)
    @id = id
    @name = name
    @image_url = image_url
    @location = location
    @occupation = occupation
    @color = color || {bg: "#FFDA42", text: "#083461"}
  end

  def view_template
    div(class: "rounded shadow-elevation-2 d-flex flex-column position-relative", style: "max-width: 177px; min-width: 177px;") do
      link_to testimonials_path(anchor: "collaborator_#{id}") do
        span(style: "
          font-size: 10px;
          font-weight: 500;
          text-transform: uppercase;
          position: absolute;
          top: 0;
          right: 0;
          padding: 6px 8px;
          background-color: #{color[:bg]};
          color: #{color[:text]};
          border-radius: 0 8px 0 6px;
          letter-spacing: 1.2px;
          max-width: 90%;
        ") { location }

        image_tag(image_url,
          style: "
            width: 100%;
            height: 204px;
            object-fit: cover;
            border-radius: 8px 8px 0 0;
          "
        )
        div(class: 'bg-white rounded-bottom d-flex flex-column align-items-start justify-content-center flex-grow-1',
            style: "padding-right: 9px !important; padding-left: 9px !important; padding-top: 8px !important; padding-bottom: 8px !important; gap: 5px !important;min-height: 85px;") do
          p(class: 'mb-0 text-primary text--lw') { name }
          p(class: 'mb-0 text-primary text--md') { occupation }
        end
      end
    end
  end
end
