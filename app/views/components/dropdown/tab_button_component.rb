# frozen_string_literal: true

class Dropdown::TabButtonComponent < ApplicationComponent
  def initialize(text, options = {})
    @text = text
    @id = options[:id]
    @target = options[:target]
    @is_active = options[:is_active] || false
    @selected = options[:selected] || "false"
  end

  def view_template
    button(class:"nav-link w-100 d-flex justify-content-start #{is_active? ? 'active' : ''}",
            id: id,
            data: {
              bs_toggle:"tab",
              bs_target:"##{target}"
            },
            type:"button",
            role:"tab",
            aria_controls: target,
            aria_selected: selected) do
              plain text
            end

  end

  private

  def is_active?
    @is_active
  end
  attr_reader :text, :id, :target, :selected
end
