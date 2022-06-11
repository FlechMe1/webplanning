# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts "CREATE FIRST USER"
u = User.new(email: 'p.gruson@gmail.com', lastname: 'Gruson', firstname: 'Paul', password: 'Ch@ngeM3!', password_confirmation: 'Ch@ngeM3!');
if u.save
  puts "User #{u.name} créé"
  u.confirm
  puts "User #{u.name} confirmé"
  u.add_role :admin
  puts "User #{u.name} adminifié"
else
  puts "Un probleme est survenur #{u.errors.inspect}"
end