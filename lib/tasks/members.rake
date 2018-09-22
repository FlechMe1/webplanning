namespace :members do

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