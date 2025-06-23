namespace :article do
  desc "Randomly update two tags to visible for eahc article"
  task update_visible_tags: :environment do
    puts 'Marking as not visible...'
    Tagging.update_all(visible: false)
    puts 'Randomly marking two as visible...'
    Article.all.each do |article|
      article.taggings.sample(2).each { |t| t.update(visible: true) }
    end
    puts 'Done zo/'
  end

  desc 'Update present tags to be visible (max 2)'
  task update_tags_visibility: :environment do
    puts "Selecting articles w/ tags"
    articles = Article.all.reject { |article| article.taggings.empty? }
    puts "Setting two taggings as visible"
    articles.each do |article|
      article.taggings.each { |tagging| tagging.update(visible: false) }
      article.taggings.sample(2).each { |tagging| tagging.update(visible: true) }
      p article.taggings.where(visible: true)
    end
  end

  desc 'Update featured and main featured articles'
  task update_featured: :environment do
    puts 'Picking up most recent articles'
    articles = Article.order(updated_at: :desc).limit(5)
    articles[0].update!(main_featured: true)
    articles[1..].each { |it| it.update(featured: true) }
  end
end
