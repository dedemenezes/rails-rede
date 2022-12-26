User.destroy_all
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

puts 'Finished zo/'
