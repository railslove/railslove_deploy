namespace :backup do
  
  desc "Create a new backup using astrails-safe"
  task :run do 
    sudo "cd #{current_path}; astrails-safe -v #{current_path}/config/server/backup.rb"
  end
  
end