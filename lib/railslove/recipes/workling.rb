namespace :workling do
  
  desc "Restart Workling Client"
  task :restart, :roles => :app do 
    run "cd #{current_path}; script/workling_client stop RAILS_ENV=#{fetch(:rails_env, "production")}"
    run "cd #{current_path}; script/workling_client start RAILS_ENV=#{fetch(:rails_env, "production")}"
  end
  
  desc "Start Workling Client"
  task :start, :roles => :app do 
    run "cd #{current_path}; script/workling_client start RAILS_ENV=#{fetch(:rails_env, "production")}"
  end
  
  desc "Stop Workling Client"
  task :stop, :roles => :app do 
    run "cd #{current_path}; script/workling_client stop RAILS_ENV=#{fetch(:rails_env, "production")}"
  end
  
end

namespace :starling do
  desc "Start Starling"
  task :start do
    run "sudo starling -d -p #{fetch(:starling_port, "15151")}"
  end
end