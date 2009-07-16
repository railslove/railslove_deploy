namespace :backup do
  
  desc "Create a new backup using the astrails-safe config script from config/server/backup.rb"
  task :run do 
    sudo "cd #{current_path}; /usr/local/ruby-enterprise/bin/astrails-safe -v #{current_path}/config/server/backup.rb"
  end
  
end