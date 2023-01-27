FactoryBot.define do
  factory :member do
    name { "MyString" }
    description { "MyString" }
    occupation { "MyString" }
    role { "MyString" }
    published { false }
    observatory { nil }
    project { nil }
  end
end
