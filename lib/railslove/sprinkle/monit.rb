package :monit, :provides => :monitoring do
  description 'installs monit - a system monitoring utility which allows an admin to easily monitor files, processes, directories, or devices on your system.'
  
  source 'http://mmonit.com/monit/dist/monit-5.0.3.tar.gz' do
    post :install, 'mkdir /etc/monit'
    post :install, 'mkdir /etc/monit.d'
    post :install, 'mkdir /var/lib/monit'
  end
  
  requires :essentials, :monit_dependencies
  
  #verify do
  #  has_executable "monit"
  #end
end

package :monit_init_d do
  description "Monit init.d script."
  requires :monit
  
  transfer "#{File.dirname(__FILE__)}/../templates/monit_init", "/etc/init.d/monit" do
    post :install, "chmod +c /etc/init.d/monit"
  end
  
  #verify do 
  #  has_file "/etc/init.d/monit"
  #end
  
end
  
package :monit_dependencies do
  description "Dependencies to build monit from source"
  apt 'flex byacc'
end
