namespace :monit do 
  
  desc "Setup the monitrc and enable monit on the server"
  task :setup do 
    put render("config/server/monitrc.erb", binding), "/tmp/monitrc"
    sudo "mv /tmp/monitrc /etc/monit/monitrc"
    sudo "chown -R root:root /etc/monit"
    sudo "echo 'startup=1' | sudo tee -a /etc/default/monit"
  end
  
  desc "Upload global monit configurations. This task allows you to install system-wide monit configuration files"
  task :upload_global do
    Dir.new("config/server/monit").each do |file|
      next unless File.file?("config/server/monit/#{file}")
      put render("config/server/monit/#{file}", binding), "/tmp/#{file.gsub('.erb', "")}"
      sudo "mv /tmp/#{file} /etc/monit.d/#{file}"
      sudo "chown root:root /etc/monit.d/#{file}"
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