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
pesca_laguna, perda_quilombola, territorio_rural, fundiaria, pesqueira = types.map { |type| ConflictType.create! name: type }

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

buzios_desc = "O Observatório de Armação dos Búzios é formado por quilombolas do Quilombo de Baía Formosa. O grupo enfrenta impactos como a especulação imobiliária, descaracterização e perda do território quilombola, dificuldade de acesso a políticas públicas específicas, e vem se organizando e se posicionando na gestão ambiental pública local frente aos conflitos ambientais. Para tanto, o processo educativo e as ações com esse grupo são pautadas no tema gerador definido coletivamente: \"Descaracterização e perda do território quilombola\"."

buzios = Observatory.create!(
  name: 'Armação dos Búzios',
  email: 'pea.buzios@redeobservacao.com',
  phone_number: '21972614293',
  unity_type: type_observatory,
  neighborhood: 'Quilombo de Baía Formosa',
  city: 'Armação dos Búzios',
  street: 'Estrada da rasa',
  number: '0',
  zip_code: '28950-000',
  state: 'Rio de Janeiro',
  municipality: 'RJ',
  priority_type: quilombolas,
  conflict_type: perda_quilombola,
  description: buzios_desc
)

campos_desc = "O Observatório de Campos dos Goytacazes é formado por remanescentes quilombolas do Quilombo de Lagoa Fea. O grupo enfrenta impactos como a descaracterização e perda do território quilombola, falta de acesso e existência de políticas públicas, conflitos relacionados à falta de reconhecimento da identidade quilombola por parte da comunidade e do poder público, e vem se organizando e se posicionando na gestão ambiental pública local frente aos conflitos ambientais. Para tanto, o processo educativo e as ações com esse grupo são pautadas no tema gerador definido coletivamente: Reconhecimento da comunidade quilombola para o acesso à políticas públicas"

campos = Observatory.create!(
  name: 'Campos dos Goytacazes',
  email: 'pea.campos@redeobservacao.com',
  phone_number: '21972614293',
  unity_type: type_observatory,
  neighborhood: 'Quilombo de Lagoa FEA',
  city: 'Campos dos Goytacazes',
  street: 'Quilombo de Lagoa FEA',
  number: '0',
  zip_code: '28950-000',
  state: 'Rio de Janeiro',
  municipality: 'RJ',
  priority_type: quilombolas,
  conflict_type: perda_quilombola,
  description: campos_desc
)





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
