User.destroy_all
ConflictType.destroy_all
UnityType.destroy_all

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

puts "creating Conflicts Types"
types = [
  'Descaracterização e perda do território quilombola',
  'Descaracterização do território rural',
  'Regularização Fundiária',
  'Manutenção da Atividade Pesqueira'
]
types.each { |type| ConflictType.create! name: type }
puts "Conflict Type created: #{ConflictType.count}"

# puts "creating Projects"
# project = Project.create!(
#   name: 'Rede Observacao'
# )

# puts "creating Methodologies"
# Methodology.create!(
#   name: 'Metodologia Um',
#   project: project
# )

puts 'creating unity types'
observatory_types = ['observatory', 'platform', 'fpso']
observatory_types.each do |tipo|
  UnityType.create(name: tipo)
end
puts 'Finished zo/'
