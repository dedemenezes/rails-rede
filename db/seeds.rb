Observatory.destroy_all
UnityType.destroy_all
User.destroy_all
ConflictType.destroy_all
Category.destroy_all
PriorityType.destroy_all

puts 'DB cleaned!'

puts 'Seeding db...'
User.create!(
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
  'Inviabilização da pesca na Laguna',
  'Descaracterização e perda do território quilombola',
  'Descaracterização do território rural',
  'Regularização Fundiária',
  'Manutenção da Atividade Pesqueira'
]
types.each { |type| ConflictType.create! name: type }

puts 'Creating Priority Types...'
priorities = [
  "Pescadores Artesanais",
  "Quilombolas",
  "Marisqueiras",
  "Agricultores Familiares",
  "Pescadores de Guaiamum"
]
priorities.each { |priority| PriorityType.create! name: priority }

puts "creating Categories..."
['Teatro do Oprimido', 'Comunicação Popular', 'Educação Ambiental'].each do |name|
  Category.create! name: name
end

puts 'creating unity types'
observatory_types = ['observatory', 'platform', 'fpso']
observatory_types.each do |tipo|
  UnityType.create!(name: tipo)
end

puts 'Creating Observatory...'
observatory = Observatory.create!(
  name: 'Araruama',
  email: 'pea.araruama@redeobservacao.com',
  phone_number: '21972614293',
  unity_type: UnityType.last,
  neighborhood: 'Prainha',
  city: 'Arraial do Cabo',
  street: 'Rua Francis Barreto',
  number: '80',
  zip_code: '22358-756',
  state: 'Rio de Janeiro',
  municipality: 'RJ'
)
observatory.conflict_type = ConflictType.last
observatory.priority_type = PriorityType.last
observatory.category = Category.last
# puts "creating Projects"
# project = Project.create!(
#   name: 'Rede Observacao'
# )

# puts "creating Methodologies"
# Methodology.create!(
#   name: 'Metodologia Um',
#   project: project
# )


puts 'Finished zo/'
