FactoryBot.define do
  factory :published_event_album, class: 'Album' do
    gallery
    name { "Published Album" }
    is_event { true }
    event_date { Date.yesterday }
    published { true }
  end

  factory :unpublished_event_album, class: 'Album' do
    gallery
    name { "Unpublished Album" }
    is_event { true }
    event_date { Date.yesterday }
  end
end
