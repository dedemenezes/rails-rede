# frozen_string_literal: true

class NavItemComponent < ApplicationComponent
  def view_template
    li(class: "nav-item") do
      yield
    end
  end
end
