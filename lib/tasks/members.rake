namespace :members do

  task :set_default_association, [:file] => :environment do |t, args|
    puts "*** SET DEFAULT ASSOCIATION FOR MEMBERS ***"
    association = Association.first
    Member.update_all(association_id: association.id)
  end

  task :set_default_expired_at, [:file] => :environment do |t, args|
    puts "*** SET DEFAULT expired_at FOR MEMBERS ***"

    Member.all.each do |member|
      member.expired_at = member.updated_at + 1.year if member.expired_at.blank?
      member.save
    end
  end

  task :send_link_to_all_members, [:file] => :environment do |t, args|

    members = Member.all

    members.each do |member|

      unless member.token?
        random_token = SecureRandom.urlsafe_base64(nil, false)
        member.token = random_token
        member.save
      end

      member.send_access_link

      puts "Le membre '#{member.firstname} #{member.lastname}' a reçu son email"
    end
  end
end