require "bundler/capistrano"

# load 'deploy/assets'

load "config/recipes/base"
load "config/recipes/rvm"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/assets"
# load "config/recipes/link_database"
load "config/recipes/set_environment"
# load "config/recipes/check"

# server "62.76.178.189", :web, :app, :db, primary: true
server "62.76.187.72", :web, :app, :db, primary: true

set :user, "deployer"
set :application, "solidarnost"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:thorn/#{application}.git"
set :branch, "master"

set :debian_version, "stable"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
# set :default_shell, '/bin/sh'
after "deploy", "deploy:cleanup" # keep only the last 5 releases
