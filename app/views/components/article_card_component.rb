# frozen_string_literal: true

class ArticleCardComponent < ApplicationComponent
  include Phlex::Rails::Helpers::LinkTo

  attr_reader :article, :min_height, :highlight

  def initialize(article:, min_height:, highlight:)
    @article = article
    @min_height = min_height
    @highlight = highlight
  end

  def view_template
    div(
      class: %(article__card #{min_height} #{highlight ? "" : "reveal"}),
      data_scroll_reveal_target: "item"
    ) do
      link_to article_path(article) do
        div(
          class: %(card__image #{highlight ? "card__image--highlight" : ""}),
          style:
            %(background-image:url(#{display_banner_as_background(article)}); background-size: cover; background-position: center;)
        )
      end
      div(class: "article__card__content") do
        render Card::Article::ContentHeaderComponent.new(article:)
        render Card::Article::HeaderLinkComponent.new(article:)
        if highlight
          p do
            plain article.rich_body.to_plain_text.truncate(170)
            link_to "Ler mais", article_path(article)
          end
        end
      end
    end
  end
end
