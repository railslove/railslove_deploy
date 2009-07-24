namespace :ferm do 
  
  desc "Configure IPtables using ferm"
  task :configure do 
    put render("config/server/ferm.conf.erb", binding), "/tmp/ferm"
    sudo "mv /tmp/ferm /etc/ferm/ferm.conf"
    sudo "/etc/init.d/ferm restart"
  end
  
end