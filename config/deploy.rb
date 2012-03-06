require "bundler/capistrano"

set :application, "gem_server"
set :bundle_flags, "--deployment"
set :rack_env, :production

set :scm, :git
set :scm_verbose, true
set :repository,  "git@github.com:tnitsche/gem_server.git"

default_run_options[:pty] = true
set :ssh_options, { :forward_agent => true }
set :use_sudo,        false

role :web, "schnecke"
role :app, "schnecke"
role :db,  "schnecke", :primary => true
set :deploy_to, "/var/www/roots/#{application}/"

set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"
set :normalize_asset_timestamps, false

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do 
    run "cd #{current_path} ; bundle exec unicorn -c #{current_path}/config/unicorn.rb -D -E #{rack_env};"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do 
    run "#{try_sudo} kill `cat #{unicorn_pid}`"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end
