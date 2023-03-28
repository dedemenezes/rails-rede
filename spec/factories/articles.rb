FactoryBot.define do
  factory :article do
    header { "This is a very nice header for this article" }
    sub_header { "This is what we meant with a sub header" }
    featured { true }
    published { true }
    association :project, factory: :rede
    rich_body {
      ActionText::RichText.create(
        { record_type: 'Article',
          name: "content",
          body: "<div class='trix-content'>HELLO</div>",
          record_id: self.id }
      )
    }
  end
end
