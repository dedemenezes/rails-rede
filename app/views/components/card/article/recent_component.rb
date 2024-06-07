module Card
  module Article
    class RecentComponent < ApplicationComponent
      attr_reader :article, :index, :top_four

      def initialize(article:, index:, top_four:)
        @article = article
        @index = index
        @top_four = top_four
      end

      def view_template
        div(
          class:
            %(article__recent_new #{"mb-4" unless index == top_four.size - 1} mb-xl-0 reveal),
          data_scroll_reveal_target: "item"
        ) do
          link_to article_path(article) do
            div(
              class: "card__image-bg card__image-bg--recent",
              style:
                %(background-image: url(#{display_banner_as_background(article)});)
            )
          end
          div(class: "article__info px-3 py-2 py-lg-3 pe-lg-3") do
            div(class: "info__header d-flex align-items-center gap-3 mb-2") do
              small do
                link_to article.updated_at.strftime("%d.%m.%Y"),
                        article_path(article)
              end
              div(class: 'flex-grow-1') do
                article.visible_tags.each_with_index do |tagging, index|
                  render TagComponent.new(name: tagging.tag.name)
                end
              end
            end
            link_to article_path(article) do
              h5(class: "text-reset mb-lg-0 fs-6") { article.header.truncate(81) }
            end
          end
        end
      end
    end

  end
end
