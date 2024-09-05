FactoryBot.define do
  factory :still_valid, class: Video do
    url { "https://www.youtube.com/watch?v=_CL6n0FJZpk" }
    # association :album, factory: :video_album
    name { 'Video Test' }
  end
end
