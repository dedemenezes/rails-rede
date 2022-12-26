FactoryBot.define do
  factory :coppola, class: 'User' do
    email { 'francis@coppola.com' }
    password { '123456' }
    first_name { 'francis' }
    last_name { 'coppola' }
  end
end
