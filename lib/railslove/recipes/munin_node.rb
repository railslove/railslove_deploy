namespace :munin_node do
  
  desc "Upload the munin node configuration"
  task :configure do 
    put render("config/server/munin-node.conf.erb", binding), "/tmp/munin_node"
    sudo "mv /tmp/munin_node /etc/munin/munin-node.conf"
    sudo "chown -R root:root /etc/munin/munin-node.conf"
  end
  
end