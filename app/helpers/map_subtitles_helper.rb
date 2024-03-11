module MapSubtitlesHelper
  def self.icons_and_texts
    {
      polygons: {
        'icon--dark-blue': 'Território do grupo tradicional',
        'icon--green': 'Unidade de Conservação Terrestre',
        'icon--light-blue': 'Unidade de Conservação Marinha',
        'icon--pink': 'Área de moradia',
        'icon--red': 'Área de Conflito'
      },
      pins: {
        'ylw-pushpin': 'Observatório e instituições',
        'blue-pushpin': 'Práticas laborais e sociais',
        'red-pushpin': 'Estruturas que interferem na atividade social',
        'pink-pushpin': 'Locais de serviço público',
        'wht-pushpin': 'Outros pontos de referências'
      },
      lines: {
        black: 'Dutos',
        blue: 'Rios',
        pink: 'Ruas'
      },
      icons: {
        'wht-blank': 'Locais de serviços públicos',
        'blu-blank': 'Pontos importantes para práticas laborais',
        'water': 'Lagoa'
      }
    }
  end
end
