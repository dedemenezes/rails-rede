FactoryBot.define do
  factory :observatory do
    headline { "MyString" }
    name { "MyString" }
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
end
