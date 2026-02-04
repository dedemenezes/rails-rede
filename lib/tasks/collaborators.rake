namespace :collaborators do
  desc "Populate with default collaborators"
  task seed: :environment do
    if Collaborator.any?
      puts "Clean collaborators?"
      should_clean = gets.chomp
    end
    Seeds::Collaborators.clean if should_clean
    Seeds::Collaborators.create!
  end
end
