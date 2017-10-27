require 'mina/rvm'
require 'mina/git'
require 'mina/bundler'
require 'mina/rails'
require 'mina/whenever'
require 'mina/puma'

set :user,              'saleshop'
set :application_name,  'saleshop.online'
set :domain,            '194.135.83.116' # hostens
set :deploy_to,         "/home/#{fetch(:user)}/#{fetch(:application_name)}"
set :repository,        'git@bitbucket.org:kereal/saleshop.online.git'
set :branch,            'master'
set :keep_releases,     2
set :shared_dirs,       fetch(:shared_dirs, []).push('log', 'tmp', 'public/system')
set :shared_files,      fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')
set :bundle_options,    lambda { %{--without development:test --path vendor/bundle --deployment} }
set :rvm_use_path,      '/usr/local/rvm/scripts/rvm'



task :remote_environment do
  invoke :'rvm:use', '2.4.1'
end

task :setup do
  command %(mkdir -p "#{fetch(:shared_path)}/tmp/sockets")
  command %(mkdir -p "#{fetch(:shared_path)}/tmp/pids")
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
      invoke :'puma:restart'
      invoke :'whenever:update'
    end
  end
end
