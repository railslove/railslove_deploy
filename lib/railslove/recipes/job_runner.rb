namespace :job_runner do
  desc "Start your Job runner process" 
  task :start, :roles => :app do
    run "cd #{release_path}; RAILS_ENV=#{fetch(:rails_env, "production")} #{fetch(:job_runner_script, "script/job_runner")} stop" 
  end

  desc "Stop your Job runner process" 
  task :stop, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{fetch(:rails_env, "production")} #{fetch(:job_runner_script, "script/job_runner")} stop" 
  end
  
  desc "Restart your Job runner process" 
  task :restart, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{fetch(:rails_env, "production")} #{fetch(:job_runner_script, "script/job_runner")} restart" 
  end
  
end