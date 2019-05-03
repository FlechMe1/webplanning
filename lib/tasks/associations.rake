namespace :associations do

  task :set_token, [:file] => :environment do |t, args|
    puts "*** SET TOKEN ***"
    Association.all.each do |a|
      a.token = SecureRandom.base64(24)
      a.save
    end
  end

end



