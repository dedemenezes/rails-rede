SitemapGenerator::Sitemap.default_host = 'https:/www.pearedeobservacao.com'
SitemapGenerator::Sitemap.create do
  add '/observatorios'
  add '/contact_us'
  add '/contato'
  add '/sobre'
  add '/mapa-de-conflitos'
end
# SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks





# blog_sitemap_opts = {
#   create_index: false,
#   default_host: 'https://fastruby.io/blog',
#   compress: false,
#   sitemaps_path: '',
#   namer: SitemapGenerator::SimpleNamer.new(:blog_sitemap)
# }

# SitemapGenerator::Sitemap.create blog_sitemap_opts do
#   pages = Dir["public/blog/**/*.html"]
#   pages.each do |blog_page|
#     add blog_page, changefreq: 'weekly'
#   end
# end

# sitemap_opts = {
#   create_index: false,
#   default_host: 'https://fastruby.io',
#   compress: false,
#   sitemaps_path: '',
#   namer: SitemapGenerator::SimpleNamer.new(:sitemap)
# }

# SitemapGenerator::Sitemap.create sitemap_opts do
#   add '/#contact-us', changefreq: 'weekly'
#   add '/team', changefreq: 'weekly'

#   # all other important pages here

#   add_to_index "blog_sitemap.xml", host: ENV['SITE_URL']
# end
