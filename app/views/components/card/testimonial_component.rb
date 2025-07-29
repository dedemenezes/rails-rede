# frozen_string_literal: true

class Card::TestimonialComponent < ApplicationComponent
  include Phlex::Rails::Helpers::ImageTag

  def initialize(collaborator:, index:)
    @collaborator = collaborator
    @index = index
  end

  def view_template
    div(class: "testimonial d-flex flex-column align-items-start flex-md-row #{"flex-md-row-reverse" if index.odd?} shadow-elevation-2") do
      image_tag(collaborator.avatar, width: '100px', height: '100px', class: "testimonial__avatar rounded-circle fit--cover flex-shrink-0 mb-3 mb-md-0 mx-auto")
      div(class: "testimonial_content flex-grow-1 d-flex flex-column align-items-start #{ index.odd? ? 'me-md-3 align-items-md-end' : 'ms-md-3 align-items-md-start'}") do
        p(class: "testimonial__author mb-1 fw-bold") do
          "#{collaborator.name} | #{ collaborator.location }"
        end
        p(class: "testimonial__occupation mb-2 text--md") do
          collaborator.display_occupation
        end
        p(class: "testimonial__text mb-0 text--lw", style: "text-align: justify;") do
          collaborator.testimonial
        end
      end
    end
  end

  private

  attr_reader :collaborator, :index
end
