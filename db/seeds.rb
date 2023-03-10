puts 'Cleaning DB...'
Project.destroy_all
Methodology.destroy_all
Observatory.destroy_all
UnityType.destroy_all
User.destroy_all
ConflictType.destroy_all
PriorityType.destroy_all
Tag.destroy_all
Article.destroy_all
puts 'DB cleaned!'

puts 'Creating Project...'
rede_observacao = Project.create! name: 'Rede Observação'

puts "creating Methodologies..."
['Teatro do Oprimido', 'Comunicação Popular', 'Formação e Pesquisa'].each do |name|
  Methodology.create! name: name, project: rede_observacao
end

puts 'testing user REMOVE!'
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
  "beneficiadoras de pescado".capitalize,
  "Quilombolas",
  "Marisqueiras",
  "Agricultores Familiares",
  "Pescadores de Guaiamum"
]
pescadores_artesanais, beneficadoras, quilombolas, mariqueiras, agricultores = priorities.map { |priority| PriorityType.create! name: priority }

puts 'creating unity types'
observatory_types = ['observatory', 'platform', 'fpso']
type_observatory, platform, fpso = observatory_types.map { |tipo| UnityType.create!(name: tipo) }

puts 'Creating Observatory...'
description = "O Observatório Araruama é formado por voluntários da comunidade e pescadores artesanais da laguna de Araruama e tem como objetivo identificar e monitorar os impactos da cadeia produtiva de óleo e gás que inviabiliza a pesca artesanal na laguna de Araruama.
Os pescadores artesanais retratam a dificuldade de acesso as politicas públicas em relação à precariedade na infraestrutura para o escoamento do pescado, no qual muitas vezes precisam repassar para atravessadores a preços baixos, desvalorizando o seu trabalho, além da poluição na Laguna de Araruama e o afastamento das suas residências próximas da laguna causadas pelo crescente aumento populacional na região, ocasionado pelo aumento de polos de extração de petróleo na região dos lagos.
Outro problema relatado é a barreira encontrada pelos pescadores na ocupação de espaços de decisões, onde são debatidos assuntos que podem interferir na prática do seu trabalho como a implantação do transporte hidroviário, Ferry Boat, que atualmente ocupa um espaço considerado da laguna influenciando diretamente na dinâmica da pesca."
Observatory.create!(
  name: 'Araruama',
  email: 'pea.araruama@redeobservacao.com',
  phone_number: '21972614293',
  unity_type: type_observatory,
  neighborhood: 'Laguna de Araruama',
  city: 'Araruama',
  street: 'Av. Brasil',
  number: '10',
  zip_code: '22358-756',
  state: 'Rio de Janeiro',
  municipality: 'RJ',
  priority_type: PriorityType.first,
  conflict_type: ConflictType.first,
  description: description
)

arraial_desc = "O Observatório de Arraial do Cabo é formado por marisqueiras, beneficiadoras de pescado e pescadores artesanais da Prainha. O grupo enfrenta impactos relacionados à dinâmica demográfica, perda de território e maretório,  conflitos com Unidade de Conservação e vem se organizando e se posicionando na gestão ambiental pública local frente aos conflitos ambientais. Para tanto, o processo educativo e as ações com esse grupo são pautadas no tema gerador definido coletivamente: Viabilização da gestão pesqueira da Reserva Extrativista Marinha (Resex-Mar) de Arraial do Cabo."

arraial = Observatory.create!(
  name: 'Arraial do Cabo',
  email: 'pea.arraial-do-cabo@redeobservacao.com',
  phone_number: '21972614293',
  unity_type: type_observatory,
  neighborhood: 'Prainha',
  city: 'Arraial do Cabo',
  street: 'Prainha',
  number: '100',
  zip_code: '22358-756',
  state: 'Rio de Janeiro',
  municipality: 'RJ',
  priority_type: mariqueiras,
  conflict_type: ConflictType.first,
  description: arraial_desc
)

p arraial.inspect
p arraial.priority_type




puts 'Creating tags...'

%w[Pescadores Araruama].each { Tag.create! name: _1 }

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
