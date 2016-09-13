rails_env = 'production'

working_directory "/home/webplanning/webplanning_production/current"
worker_processes  4
preload_app       true
timeout           30

listen      '/tmp/unicorn_webplanning_production.sock', :backlog => 2048

pid         "/home/webplanning/webplanning_production/shared/pids/unicorn.pid"

stderr_path "/home/webplanning/webplanning_production/shared/log/unicorn.log"

stdout_path "/home/webplanning/webplanning_production/shared/log/unicorn.log"

GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!

  old_pid = "/home/webplanning/webplanning_production/shared/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end


after_fork do |server, worker|
  ActiveRecord::Base.establish_connection

  worker.user('rails', 'rails') if Process.euid == 0 && rails_env == 'production'
end
