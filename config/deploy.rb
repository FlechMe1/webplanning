require "bundler/capistrano"

# multi staging
set :stages, %w(staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage' # import: after defining stages

# allowing shell interactions
default_run_options[:pty] = true
set :ssh_options, { :forward_agent => true }

set :application, "webplanning" # Le nom de votre application
set :user, "webplanning"
# Le nom d'utilisateur de la session (celui que l'on a créé au début

set(:deploy_to) { "/home/#{user}/#{application}_#{rails_env}" }
set(:releases_path)     { File.join(deploy_to, version_dir) }
set(:shared_path)       { File.join(deploy_to, shared_dir) }
set(:current_path)      { File.join(deploy_to, current_dir) }
set(:release_path)      { File.join(releases_path, release_name) }

set :deploy_via, :remote_cache
set :scm, :git
set :repository,  "https://github.com/p0k3/webplanning.git" #Ici mettre votre repo GIT

# number of releases we want to keep
set :keep_releases, 1

set :use_sudo, false

# # unicorn informations
set(:unicorn_config) { "#{current_path}/config/unicorn.rb" }
set(:unicorn_pid) { "#{shared_path}/pids/unicorn.pid" }
set(:unicorn_bin) { "#{current_path}/bin/unicorn" }

# useful for rbenv
set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}
set :bundle_flags, "--deployment --quiet --binstubs"

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run <<-CMD
      cd #{current_path} && #{unicorn_bin} -c #{unicorn_config} -E #{rails_env} -D
    CMD
  end

  task :force_stop, :roles => :app, :except => { :no_release => true } do
    run <<-CMD
      if [ -e #{unicorn_pid} ]; then
        kill -9 $(cat #{unicorn_pid});
      fi
    CMD
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    run <<-CMD
      if [ -e #{unicorn_pid} ]; then
        kill $(cat #{unicorn_pid});
      fi
    CMD
  end

  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run <<-CMD
      if [ -e #{unicorn_pid} ]; then
        kill -s QUIT $(cat #{unicorn_pid});
      fi
    CMD
  end

  task :reload, :roles => :app, :except => { :no_release => true } do
    run <<-CMD
      if [ -e #{unicorn_pid} ]; then
        kill -s USR2 $(cat #{unicorn_pid});
      fi
    CMD
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run <<-CMD
      if [ -e #{unicorn_pid} ]; then
        kill -9 $(cat #{unicorn_pid});
        sleep 3;
        cd #{current_path} && #{unicorn_bin} -c #{unicorn_config} -E #{rails_env} -D;
      fi
    CMD
  end

  desc "Update IMG size Paperclip"
  task :build_missing_paperclip_styles, roles: :app do
    rails_env = fetch(:rails_env, "staging")

    run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec rake paperclip:refresh class=Picture"
  end

end

desc "Create shared folders."
after 'deploy:setup', :roles => :app do
  # for unicorn
  run "mkdir -p #{shared_path}/tmp/sockets"
  run "mkdir -p #{shared_path}/tmp/cache"
  run "mkdir -p #{shared_path}/tmp/sessions"
  run "mkdir -p #{shared_path}/config"
  run "mkdir -p #{shared_path}/files"
end


desc "Link database.yml and unicorn.rb"
after 'deploy:assets:symlink', :roles => :app do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  run "ln -nfs #{shared_path}/config/system_pay.yml #{release_path}/config/system_pay.yml"
  run "ln -nfs #{shared_path}/config/secrets.yml #{release_path}/config/secrets.yml"
  run "ln -nfs #{shared_path}/config/unicorn.rb #{release_path}/config/unicorn.rb"
  run "ln -nfs /home/gemstatic/static #{release_path}/public" # serve static files
end

desc "Migrate Database"
before "deploy:assets:precompile", "deploy:migrate"

after "deploy:update_code", "deploy:cleanup"
