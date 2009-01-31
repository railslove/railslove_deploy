namespace :deploy do
  
  desc "restart"
  task :restart, :roles => :web do
    passenger.restart
  end
  
  desc "restart"
  task :start, :roles => :web do
    passenger.restart
  end
  
  desc "stop"
  task :stop, :roles => :web do
  end
  
  namespace :web do 
    
    desc "disable "
    task :disable, :roles => :web do 
      on_rollback {
        run "rm #{current_path}/public/index.html"
      }
      run "ln -l #{shared_path}/system/maintenance.html #{current_path}/public/index.html"
    end
    
    desc "enable "
    task :enable, :roles => :web do 
      run "rm #{current_path}/public/index.html"
    end
    
    desc "Restart Apache"
    task :restart, :roles => :web do
      apache.restart
    end
    
    desc "Start Apache"
    task :start, :roles => :web do
      apache.start
    end
    
    desc "Stop Apache"
    task :stop, :roles => :web do
      apache.stop
    end
    
  end
  
  desc "initial"
  task :initial do 
    stack.setup
    gems.install
    setup
    cold
  end
  
end