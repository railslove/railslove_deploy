namespace :passenger do
  
  desc "restart"
  task :restart, :roles => :web do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  
  namespace :info do
    desc "memory"
    task :memory, :roles => :app do
      run "passenger-memory-stats" do |channel, stream, data|
        puts data
      end
    end
   
    desc "Show general info"
    task :general do
      run "passenger-status" do |channel, stream, data|
        puts data
      end
    end
  end
  
end