namespace :monit do 
  
  desc "Setup the monitrc and enable monit on the server"
  task :setup do 
    put render("config/server/monitrc.erb", binding), "/tmp/monitrc"
    sudo "mv /tmp/monitrc /etc/monit/monit.rc"
    sudo "echo 'startup=1' | sudo tee -a /etc/default/monit"
  end
  
  desc "Upload global monit configurations. This task allows you to install system-wide monit configuration files"
  task :upload_global do
    Dir["config/server/monit/*"].each do |file|
      put render("config/server/monit/#{file}", binding), "/tmp/#{file}"
      sudo "mv /tmp/#{file} /etc/monit.d/#{file}"
    end
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