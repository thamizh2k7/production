server "sociorent.codingmart.com", :app, :web, :db, :primary => true
set :deploy_to, "/var/www/sociorent"
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false
set :rails_env, "development" #added for delayed job 

after 'deploy:update_code' do
  # run "cd #{release_path}; RAILS_ENV=production rake assets:precompile"
  run "cd #{release_path}; RAILS_ENV=development"
  run "mkdir -p #{release_path}/tmp/cache;"
  run "chmod -R 777 #{release_path}/tmp/cache;"
  run "mkdir -p #{release_path}/public/uploads;"
  run "chmod -R 777 #{release_path}/public/uploads"
  run "cd #{release_path} && bundle --deployment"

  #run "cd #{release_path} && rake db:seed"
  run "cd #{release_path} && rake db:create"
  run "cd #{release_path} && rake db:migrate"
  run "cd #{release_path} && rake db:seed"
  run "cd #{release_path} && rake assets:precompile"
end

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end