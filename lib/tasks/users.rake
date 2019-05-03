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

  task :set_default_association, [:file] => :environment do |t, args|
    puts "*** SET DEFAULT ASSOCIATION FOR USERS ***"
    association = Association.first

    User.all.each do |u|
      u.associations << association unless u.associations.pluck(:id).include?(association.id)
    end
  end
end