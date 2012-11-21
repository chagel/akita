require "rvm/capistrano"
require "bundler/capistrano"

set :application, "akita"
set :repository,  "git://github.com/chagel/akita.git"
set :branch, "master"
set :user, "webuser"
set :use_sudo, false
set :scm, :git

set :deploy_to, "/home/webuser/www/akita"
set :current_path, "#{deploy_to}/current"
set :releases_path, "#{deploy_to}/releases/"
set :shared_path, "#{deploy_to}/shared"
set :maintenance_template_path, "public/update.html"

set :bundle_without, [:darwin, :development, :test]

role :web, "74.207.253.166"                          # Your HTTP server, Apache/etc
role :app, "74.207.253.166"                          # This may be the same as your `Web` server
role :db, "74.207.253.166", :primary => true

namespace:deploy do
  namespace:web do 
    task:start do
    end

    task:stop do
    end

    after "deploy:restart", :roles => :app do
      #add any tasks in here that you want to run after the project is deployed
      run "rm -rf #{release_path}.git"
      run "chmod -R 755 #{current_path}"
      run "touch #{File.join(current_path,'tmp','restart.txt')}"
    end
  end
end

