# frozen_string_literal: true

class TagComponent < ApplicationComponent
  attr_reader :tag

  def initialize(tag:)
    @tag = tag
  end

  def view_template
    # "search"=>{}
    a(href: articles_path(search: { tag.name => tag.id })) do
      small(class: 'tag') { tag.name }
    end
  end
end
# <%= link_to articles_path(tags: [tag.name]) do %>
#   <small class="tag"><%= tag.name %></small>
# <% end %>
