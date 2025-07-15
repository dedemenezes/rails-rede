# frozen_string_literal: true

class Dropdown::TogglerComponent < ApplicationComponent
  def initialize(text)
    @text = text
  end

  def view_template
    button(class: 'nav-link', type: 'button', data: { bs_auto_close: "outside", bs_toggle: "dropdown" }, aria_expanded: "false") do
      span(class: "navbar-menu-item-arrow") { text }
      i(class: "fa-solid fa-chevron-down", style: "opacity: 0.7;")
    end
  end

  attr_reader :text
end
