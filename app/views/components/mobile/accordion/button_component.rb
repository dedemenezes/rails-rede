# frozen_string_literal: true

class Mobile::Accordion::ButtonComponent < ApplicationComponent
  def initialize(text:, target:)
    @text = text
    @target = target
  end

  def view_template
    button(
      class: "accordion-button shadow-none rounded p-3 ps-2 text-rede-primary fw-500 collapsed",
        type: "button",
        data: {
          bs_toggle: "collapse",
          bs_target: "#flush-#{target}"
        },
        aria_expanded: "false",
        aria_controls: "flush-#{target}"
    ) do
      span { text }
    end
  end

  private

  attr_reader :text, :target
end
