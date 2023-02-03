FactoryBot.define do
  factory :article_tag do
    association :tag, factory: :tag
    association :article, factory: :article
  end
end
