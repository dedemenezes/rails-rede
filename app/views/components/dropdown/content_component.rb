# frozen_string_literal: true

class Dropdown::ContentComponent < ApplicationComponent
  def initialize(extra_class: "")
    @extra_class = extra_class
  end

  def view_template(&)
    div(class: "dropdown-menu dropdown-menu-radius-bottom w-100 shadow-bottom overflow-hidden bg-body border-0 p-0 mt-n1", data: { bs_popper: "static" }) do
      div(class: "bg-white shadow-elevation-1 #{@extra_class}") do
        div(class: "container", &)
      end
    end
  end

  private

  attr_reader :extra_class
end
