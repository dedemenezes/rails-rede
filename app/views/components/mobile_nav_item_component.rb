# frozen_string_literal: true

class MobileNavItemComponent < ApplicationComponent
  def initialize(text, url)
    @text = text
    @url = url
  end

  def view_template
    li do
      link_to text, url,
              class: "bg-white text-rede-primary text-decoration-none d-flex justify-content-between align-items-center border-0 w-100 fs-16 p-3 ps-2 fw-500"
    end
  end

  private

  attr_reader :text, :url
end
