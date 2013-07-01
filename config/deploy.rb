set :application, 'sociorent'
set :scm, :git
set :repository, "git@github.com:thamizh2k7/production.git"
set :user, "root"
set :scm_passphrase, ""
set :branch, "master"
set :rvm_type, :system
set :rvm_path, "/usr/local/rvm"
#set :deploy_via, :remote_cache
require 'capistrano/ext/multistage'
set :stages, ["production", "development"]
set :default_stage, "development"
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
