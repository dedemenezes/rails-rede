FactoryBot.define do
  factory :published_event_album, class: 'Album' do
    gallery
    name { "Published Album" }
    category { 'photo' }
    is_event { true }
    event_date { Date.yesterday }
    published { true }
  end

  factory :video_album, class: 'Album' do
    association :gallery, factory: :video_gallery
    name { "[Album] - Video Published" }
    category { 'photo' }
    # is_event { true }
    # event_date { Date.yesterday }
    published { true }
  end

  factory :unpublished_event_album, class: 'Album' do
    gallery
    name { "Unpublished Album" }
    category { 'document' }
    is_event { true }
    event_date { Date.yesterday }
  end
end
