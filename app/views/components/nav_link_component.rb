# frozen_string_literal: true

class NavLinkComponent < ApplicationComponent
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::Request

  def initialize(text, link_path, opts={})
    @link_path = link_path
    @text = text
    @css_class = opts[:css_class]
  end

  def view_template
    link_to link_path, class: "nav-link  #{current_class?(link_path)} #{css_class}" do
      text
    end
  end

  private
  attr_reader :link_path, :text, :css_class
end
