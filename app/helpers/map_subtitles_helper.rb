module MapSubtitlesHelper
  POLYGONS = {
    'icon--dark-blue': 'Território do grupo tradicional',
    'icon--green': 'Unidade de Conservação Terrestre',
    'icon--light-blue': 'Unidade de Conservação Marinha',
    'icon--pink': 'Área de moradia',
    'icon--red': 'Área de Conflito'
  }.freeze

  PINS = {
    'ylw-pushpin': 'Observatório e instituições',
    'blue-pushpin': 'Práticas laborais e sociais',
    'red-pushpin': 'Estruturas que interferem na atividade social',
    'pink-pushpin': 'Locais de serviço público',
    'wht-pushpin': 'Outros pontos de referências'
  }.freeze

  LINES = {
    black: 'Dutos',
    blue: 'Rios',
    pink: 'Ruas'
  }.freeze

  ICONS = {
    water: 'Lagoa',
    'wht-blank': 'Locais de serviços públicos',
    'blu-blank': 'Pontos importantes para práticas laborais'
  }.freeze

  def icons_and_texts
    {
      polygons: POLYGONS,
      pins: PINS,
      lines: LINES,
      icons: ICONS
    }
  end

  def water?(icon)
    icon == :water ? 'shapes' : 'paddle'
  end
end
