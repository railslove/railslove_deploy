package :monit, :provides => :monitoring do
  description 'installs monit - a system monitoring utility which allows an admin to easily monitor files, processes, directories, or devices on your system.'
  apt 'monit'
  requires :essentials
  
  config do 
    put "/etc/monit/minit.rc", ERB.new(open("#{File.dirname(__FILE__)}/../templates/monitrc.erb").read).result(binding)
    put "/etc/monit.d/apache", ERB.new(open("#{File.dirname(__FILE__)}/../templates/monitoring/apache.monit.erb").read).result(binding)
    put "/etc/monit.d/mysql", ERB.new(open("#{File.dirname(__FILE__)}/../templates/monitoring/mysql.monit.erb").read).result(binding)
    put "/etc/monit.d/memcached", ERB.new(open("#{File.dirname(__FILE__)}/../templates/monitoring/memcached.monit.erb").read).result(binding)
    put "/etc/monit.d/sshd", ERB.new(open("#{File.dirname(__FILE__)}/../templates/monitoring/sshd.monit.erb").read).result(binding)
    
    post :install, "echo 'startup=1' | sudo tee -a /etc/default/monit"
    post :install, '/etc/init.d/monit start'
  end
  
end
