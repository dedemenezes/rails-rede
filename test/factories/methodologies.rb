FactoryBot.define do
  factory :methodology do
    name { "MyString" }
    project
    card_description { 'Methodology one test'}
  end

  factory :flamenguismo, class: "Methodology" do
    name { "Flamenguismo" }
    project
    card_description { 'Methodology one test'}
  end
end
