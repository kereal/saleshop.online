require 'mina/rvm'
require 'mina/git'
require 'mina/bundler'
require 'mina/rails'
require 'mina/whenever'

set :user,              'saleshop'
set :application_name,  'saleshop'
set :domain,            '212.8.244.73'
set :deploy_to,         "/home/#{fetch(:user)}/app"
set :repository,        'git@bitbucket.org:kereal/saleshop.online.git'
set :branch,            'master'
set :shared_dirs,       fetch(:shared_dirs, []).push('log', 'tmp', 'public/system')
set :shared_files,      fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml', 'db/development.sqlite3')
set :bundle_options,    lambda { %{--without development:test --path vendor/bundle --deployment} }
set :rvm_use_path,      '/usr/local/rvm/scripts/rvm'


# banana
set :user,              'kereal'
set :application_name,  'saleshop'
set :domain,            '192.168.0.254'
set :deploy_to,         "/home/#{fetch(:user)}/apps/#{fetch(:application_name)}"
set :shared_files,      fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml', 'db/production.sqlite3')


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
      #in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
        invoke :'puma_restart'
        invoke :'whenever:update'
      #end
    end
  end
end

desc "Restart app server"
task :puma_restart => :environment do
  invoke :'puma_stop'
  invoke :'puma_start'
end

desc "Start app server"
task :puma_start => :environment do
  in_path(fetch(:current_path)) do
    # command %{export RAILS_SERVE_STATIC_FILES=true}
    command %{bundle exec rails s -b 127.0.0.1 -d -e production}
  end
end

desc "Stop app server"
task :puma_stop => :environment do
  in_path(fetch(:current_path)) do
    command %{[ -f tmp/pids/server.pid ] && bundle exec pumactl -P tmp/pids/server.pid stop || true}
  end
end