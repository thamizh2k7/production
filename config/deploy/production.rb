server "103.8.126.71", :app, :web, :db, :primary => true
set :deploy_to, "/var/www/sociorent.com"
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
  run "rm #{release_path}/log"
  run "mkdir -p #{release_path}/log;"
  run "chmod -R 777 #{release_path}/log"
  run "rm -rf #{release_path}/public/system"
  # run "mkdir -p 777 #{release_path}/public/system/"
  run "ln -s #{shared_path}/system/ #{release_path}/public/" 
  # ln -s /var/www/sociorent.com/shared/system/ /var/www/sociorent.com/current/public/
end 

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
