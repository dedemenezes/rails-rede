# frozen_string_literal: true

class NavItemComponent < ApplicationComponent
  def initialize(options={})
    @extra_css = options[:extra_css] || ""
  end

  def view_template
    li(class: "nav-item #{extra_css}") do
      yield
    end
  end

  private

  attr_reader :extra_css
end
