# frozen_string_literal: true

module Dropdown
  class TogglerComponent < ApplicationComponent
    def initialize(text, options = {})
      @text = text
      @toggler_id = options[:toggler_id]
    end

    def view_template
      button(class: 'btn nav-link', type: 'button', data: { bs_auto_close: "outside", bs_toggle: "dropdown" },
             aria_expanded: "false", id: toggler_id) do
        span(class: "navbar-menu-item-arrow") { text }
        i(class: "fa-solid fa-chevron-down", style: "opacity: 0.7;")
      end
    end

    attr_reader :text, :toggler_id
  end
end
