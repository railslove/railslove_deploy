package :passenger_gem do 
  description 'Phusion Passenger (aka mod_rails)'
  version '2.2.5'
  gem 'passenger'
  requires :ruby_enterprise
  
  verify do 
    has_gem 'passenger'
  end
end

package :passenger_apache, :provides => :appserver do
  description "Installs and configures Passenger for use with apache webserver"
  requires :apache, :passenger_gem
  
  passenger_version = '2.2.5'
  
  transfer "#{File.dirname(__FILE__)}/../templates/passenger.load", "/etc/apache2/mods-available/passenger.load", :render => true, :sudo => true
  transfer "#{File.dirname(__FILE__)}/../templates/passenger.conf", "/etc/apache2/mods-available/passenger.conf", :render => true, :sudo => true

  noop do 
    pre :install, 'passenger-install-apache2-module --auto'
    post :install, "sudo a2enmod passenger"
    post :install, 'echo "NameVirtualHost *:80" | sudo tee -a /etc/apache2/httpd.conf'
    # Restart apache to note changes
    post :install, '/etc/init.d/apache2 restart'
  end
  
  verify do
    has_file '/etc/apache2/mods-available/passenger.load'
    has_file '/etc/apache2/mods-available/passenger.conf'
  end
end

package :passenger_nginx, :provides => :appserver  do
  description "Installs and configures Passenger for use with the awesome nginx webserver"
  
  requires :passenger_gem
  
  noop do 
    pre :install, "passenger-install-nginx-module --auto --auto-download"
  end
end
