set :application, 'sociorent'
set :scm, :git
set :repository, "git@github.com:sanandnarayan/SocioRent.git"
set :scm_passphrase, ""
set :user, "root"
require 'capistrano/ext/multistage'
set :stages, ["staging", "development"]
set :default_stage, "development"

