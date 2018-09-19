namespace :users do

  task :create_member, [:file] => :environment do |t, args|

    users = User.all

    users.each do |user|
      member = Member.new
      member.firstname = user.firstname
      member.lastname = user.lastname
      member.email = user.email
      member.user_id = user.id

      member.save

      puts "Le membre '#{member.firstname} #{member.lastname}' a été créé"
    end
  end
end