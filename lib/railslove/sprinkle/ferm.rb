package :ferm do 
  description 'ferm - for Easy Rule Making. a tool to maintain complex firewalls.'
  requires :essentials
  apt 'ferm'
    
  verify do
    has_executable "ferm"
  end
end

package :ferm_conf do
  requires :ferm
  
  ferm_server_tcp_ports = "http https ssh"
  
  transfer "#{File.dirname(__FILE__)}/../templates/ferm.conf.erb", "/etc/ferm/ferm.conf", :render => true, :sudo => true do
    post :install, '/etc/init.d/ferm restart'
  end
  
  verify do
    has_file '/etc/ferm/ferm.conf'
  end
end
