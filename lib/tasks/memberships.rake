  namespace :memberships do

  task :set_default_membership, [:file] => :environment do |t, args|

    Membership.all.each do |membership|
      membership.membershipable_type = 'Team'
      membership.save
    end
  end
end