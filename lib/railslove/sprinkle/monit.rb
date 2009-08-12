package :monit, :provides => :monitoring do
  description 'installs monit - a system monitoring utility which allows an admin to easily monitor files, processes, directories, or devices on your system.'
  source 'http://mmonit.com/monit/dist/monit-5.0.3.tar.gz'
  requires :essentials, :monit_dependencies
  
  config do 
    post :install, 'mkdir /etc/monit'
    post :install, 'mkdir /etc/monit.d'
    post :install, 'mkdir /var/lib/monit'
    put "/etc/init.d/monit", open("#{File.dirname(__FILE__)}/../templates/monit_init").read, :mode => 0755
  end
  
  verify do
    has_executable "monit"
  end
end

package :monit_dependencies do
  description "Dependencies to build monit from source"
  apt 'flex byacc '
end
