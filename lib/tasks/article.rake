namespace :article do
  desc "Randomly update two tags to visible for eahc article"
  task update_visible_tags: :environment do
    puts 'Marking as not visible...'
    Tagging.update_all(visible: false)
    puts 'Randomly marking two as visible...'
    Article.all.each do |article|
      article.taggings.sample(2).each{ |t| t.update(visible: true) }
    end
    puts 'Done zo/'
  end

end
