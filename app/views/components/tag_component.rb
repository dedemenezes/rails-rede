# frozen_string_literal: true

class TagComponent < ApplicationComponent
  attr_reader :name

  def initialize(name:)
    @name = name
  end

  def view_template
    a(href: articles_path(tags: [name])) do
      small(class: 'tag') { name }
    end
  end
end
          # <%= link_to articles_path(tags: [tag.name]) do %>
          #   <small class="tag"><%= tag.name %></small>
          # <% end %>
