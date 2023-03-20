puts 'Cleaning DB...'
Methodology.destroy_all
Project.destroy_all
Observatory.destroy_all
UnityType.destroy_all
User.destroy_all
ConflictType.destroy_all
PriorityType.destroy_all
Tag.destroy_all
Article.destroy_all
puts 'DB cleaned!'

puts 'Creating Project...'
rede_observacao = Project.create! name: 'Rede Observação', banner_text: 'Trabalhamos na construção de um processo educativo crítico para fortalecer grupos locais'
image_path = Rails.root.join('app', 'assets', 'images', "hero-image.png")
rede_observacao.banner.attach(io: File.open(image_path), filename: "hero-image.png", content_type: 'image/png')

puts "creating Methodologies..."
methodologies = [
  {
    published: true,
    name: 'Teatro do Oprimido',
    description: 'O eixo de Teatro do Oprimido (TO) busca, através da utilização de exercícios, jogos e técnicas teatrais participativas, desenvolver a autonomia dos sujeitos e o fortalecimento dos grupos para a reflexão crítica sobre a realidade. Por meio da criação de cenas teatrais baseadas em situações reais de injustiça social, o TO estimula a investigação e a compreensão de suas estruturas, buscando o planejamento de ações de organização social para o seu enfrentamento.',
    header_one: 'E nos PEAs?',
    description_one: 'O TO foi incorporado como eixo pedagógico em 2017 no PEA Observação, e segue como uma das metodologias utilizadas no PEA Rede Observação. É empregado como um método de estudo e compreensão de conflitos ambientais vividos pelas comunidades com as quais o projeto trabalha.',
    header_two: '',
    description_two: 'Além disso, no decorrer dos últimos cinco anos, a partir do emprego de técnicas como o Teatro Fórum e Teatro Imagem, o eixo tem se mostrado um potente instrumento de mobilização, fortalecimento dos sujeitos e dos grupos no processo de participação na gestão ambiental pública.',
    project: rede_observacao
  },
  {
    published: true,
    name: 'Comunicação Popular',
    description: '',
    header_one: 'História',
    description_one: 'Inspirada na Teologia da Libertação e nos movimentos sociais, operários e sindical, a Comunicação Popular (CP) se caracteriza por ser um conjunto de processos comunicativos feitos a partir dos grupos vulneráveis. No licenciamento ambiental, ela tem como ponto de partida a compreensão das comunidades tradicionais sobre os conflitos ambientais em diálogo com outros saberes e conhecimentos construídos pelos grupos. ',
    header_two: 'Instrumento de valorização',
    description_two: 'Com o objetivo de munir estes grupos de ferramentas para enfrentar os conflitos que aparecem com a chegada da cadeia produtiva de óleo e gás, mas também para criar espaços de valorização da cultura e da identidade, o eixo apresenta técnicas como redação, fotografia e produção audiovisual. Desta forma, as comunidades podem expor suas ideias, sua história e seu cotidiano de forma autônoma.',
    project: rede_observacao
  },
  {
    published: true,
    name: 'Formação e Pesquisa',
    description: '',
    header_one: 'Formação',
    description_one: 'O eixo metodológico de Formação e Pesquisa (FP) tem como objetivo geral promover, junto às comunidades tradicionais impactadas, a organização comunitária e a discussão pública, contribuindo na produção de estratégias de articulação e de intervenção na gestão ambiental, tais como em conselhos, comitês e audiências públicas. Além disso, realiza o planejamento e a execução de atividades voltadas ao aprimoramento da participação popular e auxilia nos processos educativos dos outros dois eixos: Comunicação Popular e Teatro do Oprimido.',
    header_two: 'Pesquisa',
    description_two: 'No que diz respeito à pesquisa, o eixo está voltado ao acompanhamento das transformações e conflitos ambientais relacionados à cadeia produtiva de óleo e gás nos territórios. Com os elementos investigados nos municípios da área de abrangência, o PEA está produzindo um mapa para identificar os conflitos territoriais que impactam as comunidades tradicionais prioritárias da ação educativa. O mapa é mais um elemento para traçar estratégias de intervenção dos grupos sociais envolvidos.',
    project: rede_observacao
  }
]
Methodology.create! methodologies
Methodology.all.each do |m|
  2.times do |index|
    %w[jpg jpeg png].each do |extension|
      index += 1
      number = index.odd? ? 'one' : 'two'
      image_path = Rails.root.join('app', 'assets', 'images', 'methodologies', "#{m.name.parameterize}-banner-#{number}.#{extension}")
      next unless File.exist?(image_path)

      m.banner.attach(io: File.open(image_path), filename: "#{m.name.parameterize}-banner-#{number}.jpg", content_type: 'image/png')
    end
  end
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
# araruama.redeobservacao@ambiental.rio
# redeobservacao.araruama@gmail.com
araruama = Observatory.create!(
  published: true,
  name: 'Araruama',
  email: 'pea.araruama@redeobservacao.com',
  phone_number: '21972614293',
  unity_type: type_observatory,
  neighborhood: 'Laguna de Araruama',
  city: 'Araruama',
  street: 'Av. Brasil',
  number: '10/809',
  zip_code: '28970-000',
  state: 'Rio de Janeiro',
  municipality: 'RJ',
  latitude: -22.872485564827493,
  longitude: -42.33547534557519,
  priority_type: PriorityType.first,
  conflict_type: ConflictType.first,
  description: description
)

arraial_desc = "O Observatório de Arraial do Cabo é formado por marisqueiras, beneficiadoras de pescado e pescadores artesanais da Prainha. O grupo enfrenta impactos relacionados à dinâmica demográfica, perda de território e maretório,  conflitos com Unidade de Conservação e vem se organizando e se posicionando na gestão ambiental pública local frente aos conflitos ambientais. Para tanto, o processo educativo e as ações com esse grupo são pautadas no tema gerador definido coletivamente: Viabilização da gestão pesqueira da Reserva Extrativista Marinha (Resex-Mar) de Arraial do Cabo."

arraial = Observatory.create!(
  published: true,
  name: 'Arraial do Cabo',
  email: 'pea.arraial-do-cabo@redeobservacao.com',
  phone_number: '21972614293',
  unity_type: type_observatory,
  neighborhood: 'Prainha',
  city: 'Arraial do Cabo',
  street: 'R. José Pinto de Macedo',
  number: 's/n',
  zip_code: '28930-000',
  state: 'Rio de Janeiro',
  municipality: 'RJ',
  latitude: -22.963868106076266,
  longitude: -42.02533391947336,
  priority_type: mariqueiras,
  conflict_type: ConflictType.first,
  description: arraial_desc
)

buzios_desc = "O Observatório de Armação dos Búzios é formado por quilombolas do Quilombo de Baía Formosa. O grupo enfrenta impactos como a especulação imobiliária, descaracterização e perda do território quilombola, dificuldade de acesso a políticas públicas específicas, e vem se organizando e se posicionando na gestão ambiental pública local frente aos conflitos ambientais. Para tanto, o processo educativo e as ações com esse grupo são pautadas no tema gerador definido coletivamente: \"Descaracterização e perda do território quilombola\"."
buzios = Observatory.create!(
  published: true,
  name: 'Armação dos Búzios',
  email: 'pea.buzios@redeobservacao.com',
  phone_number: '21972614293',
  unity_type: type_observatory,
  neighborhood: 'Quilombo de Baía Formosa',
  city: 'Armação dos Búzios',
  street: 'Av. Doze de Novembro',
  number: '12740/A',
  zip_code: '28950-000',
  state: 'Rio de Janeiro',
  latitude: -22.79925249532444,
  longitude: -41.96957568375965,
  municipality: 'RJ',
  priority_type: quilombolas,
  conflict_type: perda_quilombola,
  description: buzios_desc
)

campos_desc = "O Observatório de Campos dos Goytacazes é formado por remanescentes quilombolas do Quilombo de Lagoa Fea. O grupo enfrenta impactos como a descaracterização e perda do território quilombola, falta de acesso e existência de políticas públicas, conflitos relacionados à falta de reconhecimento da identidade quilombola por parte da comunidade e do poder público, e vem se organizando e se posicionando na gestão ambiental pública local frente aos conflitos ambientais. Para tanto, o processo educativo e as ações com esse grupo são pautadas no tema gerador definido coletivamente: Reconhecimento da comunidade quilombola para o acesso à políticas públicas"
# cgoytacazes.redeobservacao@ambiental.rio
# davi.pea.redeobservacao@gmail.com
# rafaelapearedeobservacao@gmail.com
campos = Observatory.create!(
  published: true,
  name: 'Campos dos Goytacazes',
  email: 'pea.campos@redeobservacao.com',
  phone_number: '21972614293',
  unity_type: type_observatory,
  neighborhood: 'Quilombo de Lagoa FEA',
  city: 'Campos dos Goytacazes',
  street: 'União Futebol Clube - RJ 180 - Quilombo',
  number: 's/n',
  zip_code: '28950-000',
  state: 'Rio de Janeiro',
  municipality: 'RJ',
  latitude: -21.959826465013396,
  longitude: -41.45871068161169,
  priority_type: quilombolas,
  conflict_type: perda_quilombola,
  description: campos_desc
)

cabo_frio_desc = "O Observatório de Cabo Frio é formado por pescadores artesanais de guaiamum do Chavão. O grupo enfrenta impactos como crescimento populacional desordenado, perda de território pesqueiro, especulação imobiliária, falta de acesso e de existência de políticas públicas para manutenção da atividade pesqueira, conflitos com Unidade de Conservação, e vem se organizando e se posicionando na gestão ambiental pública local frente aos conflitos ambientais. Para tanto, o processo educativo e as ações com esse grupo são pautadas no tema gerador definido coletivamente: Manutenção do território pesqueiro."
cabo_frio = Observatory.create!(
  published: true,
  name: 'Cabo Frio',
  email: 'cabo-friense.redeobservacao@ambiental.rio',
  phone_number: '21972614293',
  unity_type: type_observatory,
  neighborhood: 'Chavão',
  city: 'Cabo Frio',
  street: 'Rua B- Parque Veneza',
  number: 'quadra 53, lote 03',
  zip_code: '28925-834',
  state: 'Rio de Janeiro',
  municipality: 'RJ',
  latitude: -22.59086326033604,
  longitude: -42.02271354306846,
  priority_type: pescadores_artesanais,
  conflict_type: pesqueira,
  description: cabo_frio_desc
)
# CHAVAO =>  22°35'19"S   42°1'22"W
itapemirim_desc = "O Observatório Itapemirim é formado por marisqueiras das localidades de Itaipava e Itaoca. O grupo enfrenta impactos como crescimento populacional, criminalização da atividade tradicional e falta de acesso a políticas públicas. No momento vem entendendo o conflito que está inserido e se organizando em busca de estratégias de enfrentamento. Para tanto, o processo educativo e as ações com esse grupo são pautadas no tema gerador definido coletivamente: Reconhecimento e estruturação da atividade das marisqueiras."

itapemirim = Observatory.create!(
  published: true,
  name: 'Itapemirim',
  email: 'itapemirim.redeobservacao@ambiental.rio',
  phone_number: '21972614293',
  unity_type: type_observatory,
  neighborhood: 'Itaipava e Itaoca',
  city: 'Itaoca',
  street: 'Av. Itapemirim',
  number: '440/sala 105',
  zip_code: '29330-000',
  state: 'Rio de Janeiro',
  municipality: 'RJ',
  latitude: -20.88840589846213,
  longitude: -40.77419706071976,
  priority_type: mariqueiras,
  conflict_type: pesqueira,
  description: itapemirim_desc
)
macae_desc = "O Observatório de Macaé tem focado suas ações na mobilização dos agricultores familiares do Imburo e na consolidação de um grupo. Após a conclusão do levantamento dos principais impactos relacionados à cadeia produtiva de petróleo e gás que afetam esses agricultores, será definido coletivamente o tema gerador municipal, que vai pautar o processo educativo com o grupo bem como monitoramento."

macae = Observatory.create!(
  published: true,
  name: 'Macaé',
  email: 'pea.macae@redeobservacao.com',
  phone_number: '2214200992',
  unity_type: type_observatory,
  neighborhood: 'Centro',
  city: 'Macaé',
  street: 'R. Dr. Bueno',
  number: '131/301',
  zip_code: '27913-190',
  state: 'Rio de Janeiro',
  municipality: 'RJ',
  latitude: -22.377997212357936,
  longitude: -41.77510307662048,
  priority_type: agricultores,
  conflict_type: territorio_rural,
  description: macae_desc
)
rio_das_ostras_desc = "O Observatório de Rio das Ostras é formado por agricultores familiares de Cantagalo. O grupo enfrenta impactos como crescimento populacional desordenado, especulação imobiliária, dificuldade de acesso a políticas públicas de incentivo à agricultura familiar, implementação e expansão da Zona Especial de Negócios, e vem se organizando e se posicionando na gestão ambiental pública local frente aos conflitos ambientais. Para tanto, o processo educativo e as ações com esse grupo são pautadas no tema gerador definido coletivamente: Acesso a políticas públicas no enfrentamento à descaracterização do território rural."

rio_das_ostras = Observatory.create!(
  published: true,
  name: 'Rio das Ostras',
  email: 'pea.rdostras@redeobservacao.com',
  phone_number: '21972614293',
  unity_type: type_observatory,
  neighborhood: 'Cantagalo',
  city: 'Rio das Ostras',
  street: 'Estr. Prof. Leandro Faria Sarzedas',
  number: '1/01',
  zip_code: '28890-000',
  state: 'Rio de Janeiro',
  municipality: 'RJ',
  latitude: -22.42278840417887,
  longitude: -41.93859410216907,
  priority_type: agricultores,
  conflict_type: territorio_rural,
  description: rio_das_ostras_desc
)
itabapoana_desc = "O Observatório São Francisco de Itabapoana é formado por agricultores da comunidade de Carrapato / Nova Belém. O grupo enfrenta impactos como êxodo rural, falta de acesso a políticas públicas de incentivo à agricultura familiar, conflitos com Unidade de Conservação e processos de regularização fundiária, e vem se organizando e se posicionando na gestão ambiental pública local frente aos conflitos ambientais. Para tanto, o processo educativo e as ações com esse grupo são pautadas no tema gerador definido coletivamente: Manutenção da integridade do território agrícola."
itabapoana = Observatory.create!(
  published: true,
  name: 'São Francisco de Itabapoana',
  email: 'sfitabapoana.redeobservacao@ambiental.rio',
  phone_number: '2227896147',
  unity_type: type_observatory,
  neighborhood: 'Barra do Itabapoana',
  city: 'São Francisco de Itabapoana',
  street: 'R. Antonio da Silva Ferreira',
  number: '61',
  zip_code: '28230-000',
  state: 'Rio de Janeiro',
  municipality: 'RJ',
  latitude: -21.298523131587253,
  longitude: -40.9699898754778,
  priority_type: agricultores,
  conflict_type: territorio_rural,
  description: itabapoana_desc
)

sao_joao_desc = "O Observatório São Francisco de Itabapoana é formado por agricultores da comunidade de Carrapato / Nova Belém. O grupo enfrenta impactos como êxodo rural, falta de acesso a políticas públicas de incentivo à agricultura familiar, conflitos com Unidade de Conservação e processos de regularização fundiária, e vem se organizando e se posicionando na gestão ambiental pública local frente aos conflitos ambientais. Para tanto, o processo educativo e as ações com esse grupo são pautadas no tema gerador definido coletivamente: Manutenção da integridade do território agrícola."
sjbarra = Observatory.create!(
  published: true,
  name: 'São João da Barra',
  email: 'pea.saojoaodabarra@redeobservacao.com',
  phone_number: '21972614293',
  unity_type: type_observatory,
  neighborhood: 'Atafona',
  city: 'São João da Barra',
  street: 'Avenida Hormes Maia',
  number: '148',
  zip_code: '28200-000',
  state: 'Rio de Janeiro',
  municipality: 'RJ',
  latitude: -21.631087756083133,
  longitude: -41.03993937012111,
  priority_type: beneficadoras,
  conflict_type: pesca_laguna,
  description: sao_joao_desc
)

kennedy_desc = "O processo de mobilização e consolidação de um grupo se mostrou desafiador ao longo do ano de 2022, no Observatório de Presidente Kennedy. Por isso, neste ano encontra-se em processo de reestruturação e, portanto, não tem um grupo consolidado. Após as tentativas de sensibilização e mobilização de pescadores e pescadoras da localidade de Marobá, o Observatório tem focado suas ações na identificação e mobilização de outro grupo prioritário. Durante esse período, identificou um grupo de agricultores familiares e atualmente está em processo de aproximação para entender os problemas enfrentados, a dimensão do conflito que estão inseridos."
kennedy = Observatory.create!(
  published: false,
  name: 'Presidente Kennedy',
  email: 'pkennedy.redeobservacao@ambiental.rio',
  phone_number: 's/n',
  unity_type: type_observatory,
  neighborhood: '',
  city: '',
  street: '',
  number: '',
  zip_code: '',
  state: 'Rio de Janeiro',
  municipality: 'RJ',
  description: kennedy_desc
)

puts 'Attaching banners and rich text'

Observatory.where(published: true).each do |obs|
  # ATTACH BANNER
  image_path = Rails.root.join('app', 'assets', 'images', 'observatorios-banners', "#{obs.name.parameterize}.jpg")
  unless File.exist?(image_path)
    image_path = Rails.root.join('app', 'assets', 'images', 'observatorios-banners', "#{obs.name.parameterize}.png")
  end
  filename = obs.name.parameterize
  obs.banner.attach(io: File.open(image_path), filename: "#{filename}-banner.png", content_type: 'image/png')

  # ADD DESCRIPTION
  ActionText::RichText.create!(record_type: 'Observatory', record_id: obs.id, name: 'rich_description', body: obs.description)

  # CREATE ALBUMS

  4.times do |i|
    sample = Observatory.all.sample
    image_path = Rails.root.join('app', 'assets', 'images', 'observatorios-banners', "#{sample.name.parameterize}.jpg")
    unless File.exist?(image_path)
      image_path = Rails.root.join('app', 'assets', 'images', 'observatorios-banners', "#{sample  .name.parameterize}.png")
    end

    album = Album.create! name: "Conselho Regional #{i}", gallery: obs.gallery
    if i == 2
      album.is_event = true
      album.event_date
      album.banner.attach(io: File.open(image_path), filename: "#{obs.name.parameterize}-album-banner.png", content_type: 'image/png')
    end
  end
end

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
