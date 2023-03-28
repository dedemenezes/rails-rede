FactoryBot.define do
  factory :observatory do
    headline { "MyString" }
    name { "Observatory" }
    description { "MyString" }
    email { "MyString" }
    phone_number { "MyString" }
    address { "MyString" }
    latitude { 1.5 }
    longitude { 1.5 }
    type { "" }
    published { false }
    association :unity_type, factory: :unity_type
  end

  factory :ninho_do_urubu, class: 'Observatory' do
    name { "Ninho do Urubu" }
    email { "ninho@urubu.com" }
    phone_number { "2197458878" }
    state { "Rio de Janeiro" }
    municipality { "RJ" }
    address { "Rua Marques de Olinda, 80" }
    published { true }
    unity_type
  end
end
