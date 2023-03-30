# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.pearedeobservacao.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:

  add '/contato', priority: 0.9
  add '/sobre', priority: 0.9
  add '/mapa-de-conflitos', priority: 0.9
  #
  # Add '/articles'
  add articles_path, :priority => 0.5, :changefreq => 'daily'

  # Add all articles:
  Article.find_each do |article|
    add article_path(article), :lastmod => article.updated_at, priority: 0.5
  end

  # Add '/observatories'
  add observatories_path, priority: 0.7
  # Add all observatories:
  Observatory.find_each do |observatory|
    add observatory_path(observatory), lastmod: observatory.updated_at, priority: 0.6
  end

  # Add '/galleries'
  add galleries_path, priority: 0.8
  # Add all galleries:
  Gallery.find_each do |gallery|
    add gallery_path(gallery), lastmod: gallery.updated_at, priority: 0.7
  end

  # Add all albums:
  Album.find_each do |album|
    add album_path(album), lastmod: album.updated_at, priority: 0.7
  end
end
