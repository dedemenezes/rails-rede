FactoryBot.define do
  factory :gallery do
    name { "Gallery" }
    association :observatory, factory: :ninho_do_urubu
  end
end
