require 'csv'
require 'active_support/inflector/transliterate'

IMAGES_PATH = File.join(__dir__, "/data/images")

def normalize(string)
  ActiveSupport::Inflector.transliterate(string.downcase.gsub(/[^a-z0-9]/, ''))
end

file = File.join(__dir__, '/data/colaboradores.csv')

puts "Cleaning collaborators..."
Collaborator.destroy_all
puts "Creating collaborators"

CSV.foreach(file, headers: :first_row, header_converters: :symbol) do |row|
  collaborator = Collaborator.new(row)
  normalized_name = normalize(collaborator.name)

  image_file = Dir.glob("#{IMAGES_PATH}/*").find do |path|
    normalize(File.basename(path, ".*")).include?(normalized_name)
  end

  if image_file
    collaborator.avatar.attach(
      io: File.open(image_file),
      filename: File.basename(image_file),
      content_type: Marcel::MimeType.for(Pathname.new(image_file))
    )
  else
    puts "⚠️ No image found for #{collaborator.name}"
  end
  collaborator.save!
  puts "Created #{collaborator.name} #{collaborator.avatar.attached? ? "with" : "without"} avatar attached"
  puts "done!"

end
