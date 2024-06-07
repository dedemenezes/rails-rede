# frozen_string_literal: true

class Card::Article::ContentHeaderComponent < ApplicationComponent
  attr_reader :article

  def initialize(article:)
    @article = article
  end

  def view_template
    div(class: 'd-flex gap-3 align-items-center mb-2') do
      small { article.updated_at.strftime('%d.%m.%Y') }
      div(class: 'flex-grow-1 d-flex gap-2 align-items-center') do
        article.visible_tags.each do |tagging|
          render TagComponent.new(name: tagging.tag.name)
        end
      end
    end
  end
end

# <div class="info__header d-flex align-items-center gap-3 mb-2">
#   <small><%= link_to article.updated_at.strftime('%d.%m.%Y'), article_path(article) %></small>
#   <% article.visible_tags.each_with_index do |tag, index| %>
#     <small class="tag"><%= link_to tag.name %></small>
#   <% end %>
# </div>
