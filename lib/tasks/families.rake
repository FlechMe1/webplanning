namespace :families do

  task :set_default_association, [:file] => :environment do |t, args|
    puts "*** SET DEFAULT ASSOCIATION FOR FAMILIES ***"
    association = Association.first
    Family.update_all(association_id: association.id)
  end

end