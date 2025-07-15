# frozen_string_literal: true

class NavLinkComponent < ApplicationComponent
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::Request

  def initialize(text, link_path, active_class: nil, css_class: nil)
    @text = text
    @link_path = link_path
    @css_class = css_class
    @active_class = active_class
  end

  def view_template
    link_to link_path, class: final_class do
      text
    end
  end

  private

  attr_reader :text, :link_path, :css_class, :active_class

  def final_class
    [
      "nav-link",
      active_class || auto_active_class,
      css_class
    ].compact.join(" ")
  end

  def auto_active_class
    request.path == link_path ? "active" : nil
  end
end
