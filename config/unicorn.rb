# -*- encoding : utf-8 -*-
#working_directory "/home/been/rails_projects/insoshi"
#pid "/home/been/rails_projects/insoshi/tmp/pids/unicorn.pid"
#stderr_path "/home/been/rails_projects/insoshi/unicorn/err.log"
#stdout_path "/home/been/rails_projects/insoshi/unicorn/out.log"
# 
#listen "/tmp/unicorn.todo.socket"
# 
#worker_processes 2
#timeout 30

# config/unicorn.rb
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
