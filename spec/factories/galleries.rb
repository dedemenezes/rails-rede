FactoryBot.define do
  factory :gallery do
    name { "Test Gallery" }
    association :observatory, factory: :ninho_do_urubu
  end

  factory :video_gallery, class: 'Gallery' do
    name { "[Gallery] - Video Published" }
    association :methodology, factory: :methodology
    published { true }
  end
end
