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
        div(class: "card__content__header d-flex justify-cotent-start gap-2") do
          small { article.updated_at.strftime("%d.%m.%Y") }
          # <small>= article.tags.first.name</small>
          div(class: "home_article_tags gap-2") do
            article.visible_tags.each_with_index do |tagging, index|
              render TagComponent.new(name: tagging.tag.name)
            end
          end
        end
        link_to article_path(article) do
          if highlight
            h5(class: "text-reset mb-lg-0") { article.header }
          else
            h5(class: "text-reset mb-lg-0 fs-6") { article.header.truncate(80) }
          end
        end
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
