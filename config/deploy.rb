require 'mina/rails'
require 'mina/git'
require 'mina/bundler'
require 'mina/rvm'    # for rvm support. (https://rvm.io)


set :user, 'kereal'          # Username in the server to SSH to.
set :application_name, 'saleshop.online'
set :domain, 'bananapipro'
set :deploy_to, "/home/#{fetch(:user)}/www/apps/#{fetch(:application_name)}"
set :repository, 'git@bitbucket.org:kereal/saleshop.online.git'
set :branch, 'master'
set :shared_dirs, fetch(:shared_dirs, []).push('log', 'tmp', 'public/system')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml', 'db/development.sqlite3')
set :bundle_options, lambda { %{--without development:test --path vendor/bundle --deployment} }
set :rvm_use_path, "/usr/local/rvm/scripts/rvm"

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  invoke :'rvm:use', '2.4.0'
end

task :setup do
  # command %{rbenv install 2.3.0}
end

desc "Deploys the current version to the server."
task :deploy do
  deploy do

    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
        invoke :'puma_restart'
      end
    end
  end
  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

desc "Restart app server"
task :puma_restart => :environment do
  in_path(fetch(:current_path)) do
    invoke :'puma_stop'
    invoke :'puma_start'
    #command %{export RAILS_SERVE_STATIC_FILES=true}
    #command %{export RAILS_ENV=production}
    #command "bundle exec pumactl -P tmp/pids/server.pid stop || true && bundle exec rails s -b 0.0.0.0 -d -e production"
  end
end

desc "Start app server"
task :puma_start => :environment do
  in_path(fetch(:current_path)) do
    command %{export RAILS_SERVE_STATIC_FILES=true}
    command %{bundle exec rails s -b 0.0.0.0 -d -e production}
  end
end

desc "Stop app server"
task :puma_stop => :environment do
  in_path(fetch(:current_path)) do
    command %{bundle exec pumactl -P tmp/pids/server.pid stop}
  end
end