set :application, "ios_dev.rails"
set :repository, "git://github.com/Loremaster/sample_app.git"


set :scm, :git

set :user, "root"

default_run_options[:pty] = true     

set :use_sudo, true

set :deploy_to, "/var/www/#{application}"


server "10.100.10.143", :app,
                          :web,
                          :db, :primary => true




after "deploy", "deploy:bundle_gems"
after "deploy:bundle_gems", "deploy:restart"


namespace :deploy do
  task :bundle_gems do
		run "cd #{deploy_to}/current && bundle install vendor/gems"
  end
  task :start do ; end
  task :stop do ; end
  task :restart, :rolers => :app, :except => {:no_release => true} do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end