require 'csv'
file = File.join(__dir__, '/data/select_on2_oo_name_from_observatory_news_on2_join_observatory_o_202303201028.csv')

Article.destroy_all
ActionText::RichText.destroy_all
CSV.foreach file, headers: :first_row, header_converters: :symbol do |row|
  header = row[:headline]
  if row[:highlight_0].present?
    sub_header = row[:highlight_0]
    inner_h1 = row[:highlight_1]
  else
    sub_header = row[:highlight_1]
  end

  if sub_header.empty? || sub_header.nil?
    # binding.break
    sub_header = header.truncate(10)
  end
  # binding.break

  text_pt_1 = row[:text_0].gsub(/<p><span.+">/, '').gsub(/<\/span.+p>/, '').gsub(/<p><br style.+<\/p>/, '').gsub('&ccedil;', 'ç').gsub('&atilde;', 'ã').gsub('&iacute;', 'í').gsub('&otilde;', 'õ').gsub('&uacute;', 'ú').gsub('&eacute;', 'é').gsub('&aacute;', 'á').gsub('&ocirc;', 'ô').gsub('&oacute;', 'ó').gsub("\r\n", '<br><br>').gsub('&nbsp;', ' ').gsub('&acirc;','a').gsub('&agrave;', 'à')

  text_pt_2 = row[:text_1].gsub(/<p><span.+">/, '').gsub(/<\/span.+p>/, '').gsub(/<p><br style.+<\/p>/, '').gsub('&ccedil;', 'ç').gsub('&atilde;', 'ã').gsub('&iacute;', 'í').gsub('&otilde;', 'õ').gsub('&uacute;', 'ú').gsub('&eacute;', 'é').gsub('&aacute;', 'á').gsub('&ocirc;', 'ô').gsub('&oacute;', 'ó').gsub("\r\n", '<br><br>').gsub('&nbsp;', ' ').gsub('&acirc;','a').gsub('&agrave;', 'à')


  observatory_name = row[:name]
  p observatory_name

  if observatory_name == "Rede Observação"
    observatory = Project.first
    record_type = 'Project'
  else
    record_type = 'Observatory'
    observatory = Observatory.find_by_name(observatory_name)
  end
  rich_text_body = "<div class='trix-content'>#{text_pt_1}<br><br><h1>#{inner_h1}</h1><br>#{text_pt_2}</div>"
  p observatory
  attributes = {
    record_type: record_type,
    name: "content_#{row[:id]}",
    body: rich_text_body,
    record: observatory
  }

  rich_body = ActionText::RichText.create(attributes)
  article = Article.new(
    header:,
    sub_header:,
    rich_body:,
    published: true
  )

  if observatory.is_a? Project
    article.project = observatory
  else
    article.observatory = observatory
  end

  article.save!

  image_path = Rails.root.join('app', 'assets', 'images', 'noticia', article.header, 'capa.jpg')
  unless File.exist?(image_path)
    image_path = Rails.root.join('app', 'assets', 'images', 'noticia', article.header, 'capa.jpeg')
  end

  if File.exist?(image_path)
    article.banner.attach(io: File.open(image_path), filename: "#{article.header.downcase.parameterize}-banner.jpg", content_type: 'image/png')
  end
  # binding.break
  p article.rich_body.to_trix_html
end
