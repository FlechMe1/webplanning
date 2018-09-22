namespace :members do

  task :send_link_to_all_members, [:file] => :environment do |t, args|

    members = Member.all

    members.each do |member|
      member.send_access_link

      puts "Le membre '#{member.firstname} #{member.lastname}' a reçu son email"
    end
  end
end