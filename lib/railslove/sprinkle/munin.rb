package :munin_node do 
  description 'munin-node - daemon to gather system ressouce information in cooperation with the main Munin program'
  requires :essentials
  # the apache stats for munin need libwww-perl
  apt 'munin-node libwww-perl'
  
  verify do
    has_executable "munin-node"
  end
end

package :munin_apache_status do 
  description "Configure the Munin node for extended apache process, access and volumne information"
  requires :munin_node
  
  noop do 
    post :install, "ln -s /usr/share/munin/plugins/apache_accesses /etc/munin/plugins/"
    post :install, "ln -s /usr/share/munin/plugins/apache_processes /etc/munin/plugins/"
    post :install, "ln -s /usr/share/munin/plugins/apache_volume /etc/munin/plugins/"
    post :install, 'sed -e "s/<\/IfModule>/ExtendedStatus On \n<\/IfModule>/g" /etc/apache2/mods-available/status.conf > /etc/apache2/mods-available/status.conf'
  end
end

package :munin do 
  description "Munin is a networked resource monitoring tool that can help analyze resource trends"
  apt 'munin'
  
  verify do 
    has_executable "munin"
  end
end