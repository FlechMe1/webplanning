namespace :teams do

  task :set_default_association, [:file] => :environment do |t, args|
    puts "*** SET DEFAULT ASSOCIATION FOR TEAMS ***"
    association = Association.first
    Team.update_all(association_id: association.id)
  end

end