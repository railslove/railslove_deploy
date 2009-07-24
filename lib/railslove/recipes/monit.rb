namespace :monit do 
  
  desc "Setup the monitrc and enable monit on the server"
  task :setup do 
    put render("config/server/monitrc.erb", binding), "/tmp/monitrc"
    sudo "mv /tmp/monitrc etc/monit/monit.rc"
    sudo "echo 'startup=1' | sudo tee -a /etc/default/monit"
  end
  
  desc "Start monit on the server"
  task :start do 
    sudo "/etc/init.d/monit start"
  end
  
  desc "Stop monit on the server"
  task :stop do 
    sudo "/etc/init.d/monit stop"
  end
  
end