server "176.58.103.250", :app, :web, :db, :primary => true
set :deploy_to, "/var/www/sociorent"
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false
set :rails_env, "production" #added for delayed job 


after 'deploy:update_code' do
  # run "cd #{release_path}; RAILS_ENV=production rake assets:precompile"
  run "cd #{release_path}; RAILS_ENV=production"
  run "mkdir -p #{release_path}/tmp/cache;"
  run "chmod -R 777 #{release_path}/tmp/cache;"
  run "mkdir -p #{release_path}/public/uploads;"
  run "chmod -R 777 #{release_path}/public/uploads"
  run "cd #{release_path}; RAILS_ENV=production script/delayed_job stop"
  run "cd #{release_path}; RAILS_ENV=production script/delayed_job start"
end

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end