package :passenger_gem do 
  description 'Phusion Passenger (aka mod_rails)'
  version '2.2.2'
  gem 'passenger'
  requires :ruby_enterprise
end


package :passenger_nginx, :provides => :appserver  do
  description "Installs and configures the passenger for use with the awesome nginx server"
  
  requires :passenger_gem
  
  config do 
    run "passenger-install-nginx-module --auto --auto-download"
  end
end

package :passenger_apache, :provides => :appserver do
  description "Configures the passenger for use with apache"
  
  requires :apache, :passenger_gem
  
  config do 
    passenger_version = '2.2.2'
      
    pre :install, 'passenger-install-apache2-module --auto'
    put "/etc/apache2/mods-available/passenger.load", ERB.new(open("#{File.dirname(__FILE__)}/../templates/passenger.load").read).result(binding)
    put "/etc/apache2/mods-available/passenger.conf", ERB.new(open("#{File.dirname(__FILE__)}/../templates/passenger.conf").read).result(binding)
    
    # enable passenger module
    post :install, "sudo a2enmod passenger"
    post :install, 'echo "NameVirtualHost *:80" | sudo tee -a /etc/apache2/httpd.conf'
    post :install, "a2dissite 000-default"
    # Restart apache to note changes
    post :install, '/etc/init.d/apache2 restart'
  end
  
  verify do
    has_gem 'passenger'
    has_file '/etc/apache2/mods-available/passenger.load'
  end
end
