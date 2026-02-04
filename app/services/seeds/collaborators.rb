require 'csv'
require 'active_support/inflector/transliterate'
module Seeds
  class Collaborators
    IMAGES_PATH = Rails.root.join('db', 'seeds', 'data', 'images')
    class << self
      def create!
        file = Rails.root.join('db', 'seeds', 'data', 'colaboradores.csv')

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
          puts "Created #{collaborator.name} #{collaborator.avatar.attached? ? 'with' : 'without'} avatar attached"
          puts "done!"
        end
      end

      def clean
        puts "Cleaning collaborators..."
        Collaborator.destroy_all
        puts "Creating collaborators"
        self
      end

      private

      def normalize(string)
        ActiveSupport::Inflector.transliterate(string.downcase.gsub(/[^a-z0-9]/, ''))
      end
    end
  end
end

# Seeds::Collaborators.clean.create!
