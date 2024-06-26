# frozen_string_literal: true

module Card
  module Article
    class HeaderLinkComponent < ApplicationComponent
      include Phlex::Rails::Helpers::LinkTo

      attr_reader :article

      def initialize(article:)
        @article = article
      end

      def view_template
        link_to article_path(article) do
          if article.featured
            h5(class: "text-reset mb-lg-0") { article.header }
          else
            h5(class: "text-reset mb-lg-0 fs-6 line-limit-3") { article.header.truncate(::Article::HEADER_MAX_SIZE) }
          end
        end
      end
    end
  end
end
