namespace :ferm do 
  
  desc "Configure IPtables using ferm"
  task :configure do 
    put render("config/server/ferm.conf.erb", binding), "/tmp/ferm"
    # make sure we have a /etc/ferm directory. we use echo 0 to ignore errors - for example if the folder already exists. ;) 
    sudo "mkdir /etc/ferm;echo 0"
    sudo "mv /tmp/ferm /etc/ferm/ferm.conf"
    sudo "/etc/init.d/ferm restart"
  end
  
end