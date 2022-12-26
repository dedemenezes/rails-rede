User.destroy_all
Project.destroy_all

puts 'DB cleaned!'

puts 'Seeding db...'
User.create(
  email: 'francis@coppola.com',
  first_name: 'francis',
  last_name: 'coppola',
  password: '123456',
  admin: true,
  staff: true,
  username: 'fcoppola'
)

project = Project.create!(
  name: 'Rede Observacao'
)

Methodology.create!(
  name: 'Metodologia Um',
  project: project
)

puts 'Finished zo/'
