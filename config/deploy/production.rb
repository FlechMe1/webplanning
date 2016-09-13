set :rails_env, "production"

set :branch, 'master'

server 'paulgruson.fr', :app, :web
role :db, 'paulgruson.fr', :primary => true
