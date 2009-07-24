package :ferm do 
  description 'ferm - for Easy Rule Making. a tool to maintain complex firewalls.'
  apt 'ferm'
  requires :essentials
  
  verify do
    has_file '/etc/ferm/ferm.conf'
    has_executable "ferm"
  end
  
  config do 
    ferm_server_tcp_ports = "http https ssh"
    put "/etc/ferm/ferm.conf", ERB.new(open("#{File.dirname(__FILE__)}/../templates/ferm.conf.erb").read).result(binding)
    post :install, '/etc/init.d/ferm restart'
  end
  
end
