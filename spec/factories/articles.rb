FactoryBot.define do
  factory :article do
    header { "This is a very nice header for this árticle" }
    sub_header { "This is what we meant with a sub header" }
    featured { false }
    published { true }
    association :project, factory: :rede
    rich_body do
      ActionText::RichText.create(
        { record_type: 'Article',
          name: "content",
          body: "<div class='trix-content'>HELLO</div>",
          record_id: id }
      )
    end
  end
  factory :article_featured, class: 'Article' do
    header { "FEATURED This is a very nice header for this article" }
    sub_header { "FEATURED This is what we meant with a sub header" }
    featured { true }
    published { true }
    association :project, factory: :rede
    rich_body do
      ActionText::RichText.create(
        { record_type: 'Article',
          name: "content",
          body: "<div class='trix-content'>FEATURED HELLO</div>",
          record_id: id }
      )
    end
  end

  factory :observatory_article_featured, class: 'Article' do
    header { "FEATURED This is a very nice header for this article" }
    sub_header { "FEATURED This is what we meant with a sub header" }
    featured { true }
    published { true }
    association :observatory, factory: :ninho_do_urubu
    rich_body do
      ActionText::RichText.create(
        { record_type: 'Article',
          name: "content",
          body: "<div class='trix-content'>FEATURED HELLO</div>",
          record_id: id }
      )
    end
  end
end
