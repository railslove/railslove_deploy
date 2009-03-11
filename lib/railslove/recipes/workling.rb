namespace :workling do
  
  desc "Restart Workling Client"
  task :restart, :roles => :app do 
    run "cd #{current_path}; RAILS_ENV=#{fetch(:rails_env, "production")} script/workling_client stop"
    run "cd #{current_path}; RAILS_ENV=#{fetch(:rails_env, "production")} script/workling_client start"
  end
  
  desc "Start Workling Client"
  task :start, :roles => :app do 
    run "cd #{current_path}; RAILS_ENV=#{fetch(:rails_env, "production")} script/workling_client start"
  end
  
  desc "Stop Workling Client"
  task :stop, :roles => :app do 
    run "cd #{current_path}; RAILS_ENV=#{fetch(:rails_env, "production")} script/workling_client stop"
  end
  
end

namespace :starling do
  desc "Start Starling"
  task :start do
    run "sudo starling -d -p #{fetch(:starling_port, "15151")}"
  end
end