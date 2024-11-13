FactoryBot.define do
  factory :tag do
    name { "test_tag" }
  end
  factory :second_tag, class: 'Tag' do
    name { "test_tag_TWO" }
  end
end
