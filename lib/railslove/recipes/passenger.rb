namespace :passenger do
  
  desc "Restart Passenger"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  
  namespace :info do
    desc "Display the passenger-memory-stats"
    task :memory, :roles => :app do
      run "passenger-memory-stats" do |channel, stream, data|
        puts data
      end
    end
   
    desc "Display general Passernger status passernger-status"
    task :general, :roles => :app do
      run "passenger-status" do |channel, stream, data|
        puts data
      end
    end
  end
  
end