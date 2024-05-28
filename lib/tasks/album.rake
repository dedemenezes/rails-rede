namespace :album do
  desc "Update all albums with category based on attachment"
  task set_category: :environment do
    puts "Updating albums with photos attached..."
    Album
      .left_joins(:photos_attachments)
      .group(:id)
      .having("COUNT(active_storage_attachments) > 0")
      .update_all(category: 'photo')
    puts "Photos done zo/"

    puts "Updating albums with documents attached..."
    Album
      .left_joins(:documents_attachments)
      .group(:id)
      .having("COUNT(active_storage_attachments) > 0")
      .update_all(category: 'document')
    puts "Documents done zo/"

    puts "Updating albums with videos attached..."
    Album
      .left_joins(:videos)
      .group(:id)
      .having("COUNT(videos) > 0")
      .update_all category: 'video'
    puts "Videos done zo/"
  end
end
