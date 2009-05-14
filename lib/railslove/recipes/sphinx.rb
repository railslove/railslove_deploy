namespace :thinking_sphinx do
  
  desc "Configure Thinkig Sphinx"
  task :config, :roles => :app do 
    run "cd #{current_path}; rake ts:config RAILS_ENV=#{fetch(:rails_env, "production")}"
  end
  
  desc "Start Thinkig Sphinx"
  task :start, :roles => :app do 
    run "cd #{current_path}; rake ts:start RAILS_ENV=#{fetch(:rails_env, "production")}"    
  end
  
  desc "Stop Thinkig Sphinx"
  task :stop, :roles => :app do 
    run "cd #{current_path}; rake ts:stop RAILS_ENV=#{fetch(:rails_env, "production")};echo 0"
  end
  
  desc "Run Thinkig Sphinx indexing"
  task :index, :roles => :app do 
    run "cd #{current_path}; rake ts:index RAILS_ENV=#{fetch(:rails_env, "production")}"
  end
  
  desc "Bootstrap Thinkig Sphinx"
  task :bootstrap, :roles => :app do 
    run "cd #{current_path}; rake ts:stop RAILS_ENV=#{fetch(:rails_env, "production")}"
    run "cd #{current_path}; rake ts:config RAILS_ENV=#{fetch(:rails_env, "production")}"
    run "cd #{current_path}; rake ts:index RAILS_ENV=#{fetch(:rails_env, "production")}"
    run "cd #{current_path}; rake ts:start RAILS_ENV=#{fetch(:rails_env, "production")}"
  end
  
  desc "Symlink Sphinx index DB"
  task :symlink, :roles => :app do
    run "mkdir -p #{shared_path}/db/sphinx"
    run "rm -fr #{release_path}/db/sphinx && ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
  end
  
end